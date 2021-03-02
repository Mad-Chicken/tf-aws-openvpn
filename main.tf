terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_private_subnet = var.vpc_private_subnet
  vpc_public_subnet  = var.vpc_public_subnet
  vpc_azs            = var.vpc_azs
  cidr               = var.cidr
  vpc_name           = var.vpc_name
  enable_nat_gateway = var.piholeYN == "n" ? false : true
  single_nat_gateway = var.piholeYN == "n" ? false : true
}

module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "vpn_ec2" {
  source             = "./modules/ec2"
  instance_count     = "1"
  name               = "vpn"
  ami                = var.vpn_ami
  security_group_ids = [module.sg.sg_ssh_22_id,module.sg.sg_https_443_id,module.sg.sg_vpn_id]
  subnet_id          = module.vpc.public_subnets[0]
  ec2_size           = var.vpn_size
  key_name           = var.ec2_ssh_key
  tags = ["OpenVPN-as Server","dev"]
         # Description       | Environment
  user_data = <<-EOF
    #! /bin/bash
    sudo su
    apt update && apt -y install ca-certificates wget net-tools gnupg
    wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | apt-key add -
    echo "deb http://as-repository.openvpn.net/as/debian focal main">/etc/apt/sources.list.d/openvpn-as-repo.list
    apt update && apt -y install openvpn-as
    echo 'openvpn:${var.openvpn-passwd}' | chpasswd
    /usr/local/openvpn_as/scripts/sacli --key host.name --value $(/usr/local/openvpn_as/scripts/sacli IP | sed 's/"//g') ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.server.routing.private_network.0 --value ${var.vpc_public_subnet[0]} ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.server.routing.private_network.1 --value ${var.piholeYN == "n" ? var.vpc_private_subnet[1] : var.vpc_private_subnet[0]} ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.server.routing.private_network.2 --value ${var.vpc_private_subnet[1]} ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.daemon.0.client.network --value ${var.vpn_subnet} ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.daemon.0.client.netmask_bits --value 24 ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.client.routing.reroute_dns --value custom ConfigPut
    /usr/local/openvpn_as/scripts/sacli --key vpn.server.dhcp_option.dns.0 --value ${var.piholeYN == "n" ? "1.1.1.1" : var.pihole_private_ip} ConfigPut
    /usr/local/openvpn_as/scripts/sacli --user ${var.vpn_username} --key type --value user_connect UserPropPut
    /usr/local/openvpn_as/scripts/sacli --user ${var.vpn_username} --new_pass ${var.vpn_password} SetLocalPassword
    /usr/local/openvpn_as/scripts/sacli Start
  EOF
}

module "pihole_ec2" {
  source             = "./modules/ec2"
  name               = "pihole"
  instance_count     = var.piholeYN == "n" ? "0" : "1"
  ami                = var.pihole_ami
  security_group_ids = [module.sg.sg_ssh_22_id,module.sg.sg_http_80_id,module.sg.sg_pihole_id]
  subnet_id          = module.vpc.private_subnets[0]
  ec2_size           = var.pihole_size
  key_name           = var.ec2_ssh_key
  private_ip         = var.pihole_private_ip
  # PiholeAdminPassword
  tags = ["pihole ad blocker","dev"]
         # Description       | Environment
  user_data = <<-EOF
    #! /bin/bash
    sudo su -
    sleep 3
    apt-get update
    mkdir /etc/pihole
    touch /etc/pihole/setupVars.conf
    echo "BLOCKING_ENABLED=true
      QUERY_LOGGING=true
      INSTALL_WEB_SERVER=true
      INSTALL_WEB_INTERFACE=true
      LIGHTTPD_ENABLED=
      IPV4_ADDRESS=0.0.0.0
      IPV6_ADDRESS=
      CONDITIONAL_FORWARDING=
      CONDITIONAL_FORWARDING_IP=
      CONDITIONAL_FORWARDING_DOMAIN=
      CONDITIONAL_FORWARDING_REVERSE=
      PIHOLE_INTERFACE=eth0
      WEBPASSWORD=108691718ae2cac353784eca96bd8bc1be62fba752d21f66b88274643a490f93
      DNSMASQ_LISTENING=single
      DNS_FQDN_REQUIRED=false
      DNS_BOGUS_PRIV=false
      DNSSEC=true
      PIHOLE_DNS_1=1.0.0.1
      REV_SERVER=false" > /etc/pihole/setupVars.conf
    curl -L https://install.pi-hole.net | bash /dev/stdin --unattended

    sleep 1
    apt-get install -y unbound
    sleep 1
    echo "server:
      verbosity: 0
      interface: 127.0.0.1
      port: 5335
      do-ip4: yes
      do-udp: yes
      do-tcp: yes
      do-ip6: no
      prefer-ip6: no
      harden-glue: yes
      harden-dnssec-stripped: yes
      use-caps-for-id: no
      edns-buffer-size: 1472
      prefetch: yes
      num-threads: 1
      so-rcvbuf: 1m
      private-address: 192.168.0.0/16
      private-address: 169.254.0.0/16
      private-address: 172.16.0.0/12
      private-address: 10.0.0.0/8
      private-address: 10.0.1.0/8
      private-address: 10.0.2.0/8
      private-address: 10.0.99.0/24
      private-address: fd00::/8
      private-address: fe80::/10" > /etc/unbound/unbound.conf.d/pi-hole.conf
    sleep 1
    service unbound restart
    sudo sed -i 's/1.0.0.1/127.0.0.1#5335/g' /etc/pihole/setupVars.conf
  EOF
}

# PIHOLE_DNS_1=127.0.0.1#5335

/*

    wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb
    sudo apt-get install ./cloudflared-stable-linux-amd64.deb
    sudo useradd -s /usr/sbin/nologin -r -M cloudflared

    echo "CLOUDFLARED_OPTS=--port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query" > /etc/default/cloudflared

    sudo chown cloudflared:cloudflared /etc/default/cloudflared
    sudo chown cloudflared:cloudflared /usr/local/bin/cloudflared

    echo "[Unit]
      Description=cloudflared DNS over HTTPS proxy
      After=syslog.target network-online.target
      [Service]
      Type=simple
      User=cloudflared
      EnvironmentFile=/etc/default/cloudflared
      ExecStart=/usr/local/bin/cloudflared proxy-dns $CLOUDFLARED_OPTS
      Restart=on-failure
      RestartSec=10
      KillMode=process
      [Install]
      WantedBy=multi-user.target" > /etc/systemd/system/cloudflared.service
    sudo chown cloudflared:cloudflared /etc/systemd/system/cloudflared.service
    sudo systemctl enable cloudflared
    sudo syvstemctl start cloudflared




    sleep 1
    apt-get install -y unbound
    sleep 1
    echo "server:
      verbosity: 0
      interface: 127.0.0.1
      port: 5335
      do-ip4: yes
      do-udp: yes
      do-tcp: yes
      do-ip6: no
      prefer-ip6: no
      harden-glue: yes
      harden-dnssec-stripped: yes
      use-caps-for-id: no
      edns-buffer-size: 1472
      prefetch: yes
      num-threads: 1
      so-rcvbuf: 1m
      private-address: 192.168.0.0/16
      private-address: 169.254.0.0/16
      private-address: 172.16.0.0/12
      private-address: 10.0.0.0/8
      private-address: 10.0.1.0/8
      private-address: 10.0.2.0/8
      private-address: 10.0.99.0/24
      private-address: fd00::/8
      private-address: fe80::/10" > /etc/unbound/unbound.conf.d/pi-hole.conf
    sleep 1
    
    service unbound restart


*/