#!/bin/bash

echo "BEGIN -- 04-configure-vpn-tunnels.sh"

VPN_CONFIG=/vpn-config.xml
YQ=/usr/local/bin/yq

cat $VPN_CONFIG

tunnel_1=$(cat $VPN_CONFIG | $YQ -p xml | $YQ '.vpn_connection.ipsec_tunnel[0]')
tunnel_2=$(cat $VPN_CONFIG | $YQ -p xml | $YQ '.vpn_connection.ipsec_tunnel[1]')

cgw_outside_ip=$(echo "$tunnel_1" | $YQ '.customer_gateway.tunnel_outside_address.ip_address')

vgw_outside_ip_1=$(echo "$tunnel_1" | $YQ '.vpn_gateway.tunnel_outside_address.ip_address')
vgw_outside_ip_2=$(echo "$tunnel_2" | $YQ '.vpn_gateway.tunnel_outside_address.ip_address')

cgw_inside_ip_1=$(echo "$tunnel_1" | $YQ '.customer_gateway.tunnel_inside_address.ip_address')
cgw_inside_ip_2=$(echo "$tunnel_2" | $YQ '.customer_gateway.tunnel_inside_address.ip_address')

psk_1=$(echo "$tunnel_1" | $YQ '.ike.pre_shared_key')
psk_2=$(echo "$tunnel_2" | $YQ '.ike.pre_shared_key')

mv /etc/ipsec.conf /etc/ipsec.conf.old
mv /etc/ipsec.secrets /etc/ipsec.secrets.old

cat << EOF >> /etc/ipsec.conf
config setup
    charondebug="all"
    uniqueids=yes
    strictcrlpolicy=no

conn Tunnel1
    auto=start
    keyexchange=ikev2
    authby=psk
    leftid=$cgw_outside_ip
    leftsubnet=${cidr_onprem}
    right=$vgw_outside_ip_1
    rightsubnet=${cidr_aws}
    aggressive=no
    ikelifetime=28800s
    lifetime=3600s
    margintime=270s
    rekey=yes
    rekeyfuzz=100%
    fragmentation=yes
    replay_window=1024
    dpddelay=30s
    dpdtimeout=120s
    dpdaction=restart
    ike=aes256gcm16-sha384-ecp384!
    esp=aes256gcm16-sha384-ecp384!
    keyingtries=%forever

    ## Please note the following line assumes you only have two tunnels
    ## in your Strongswan configuration file. This "mark" value must be
    ## unique and may need to be changed based on other entries in your
    ## configuration file.
    mark=100

    ## Uncomment the following line to utilize the script from the
    ##   "Automated Tunnel Healhcheck and Failover"
    ## section. Ensure that the integer after "-m" matches the "mark"
    ## value above, and <VPC CIDR> is replaced with the CIDR of your
    ## VPC (e.g. 192.168.1.0/24)
    leftupdown="/etc/ipsec.d/aws-updown.sh -ln Tunnel1 -ll $cgw_inside_ip_1/30 -lr $vpn_inside_ip_1/30 -m 100 -r ${cidr_aws}"

conn Tunnel2
    auto=start
    keyexchange=ikev2
    authby=psk
    leftid=$cgw_outside_ip
    leftsubnet=${cidr_onprem}
    right=$vgw_outside_ip_2
    rightsubnet=${cidr_aws}
    aggressive=no
    ikelifetime=28800s
    lifetime=3600s
    margintime=270s
    rekey=yes
    rekeyfuzz=100%
    fragmentation=yes
    replay_window=1024
    dpddelay=30s
    dpdtimeout=120s
    dpdaction=restart
    ike=aes256gcm16-sha384-ecp384!
    esp=aes256gcm16-sha384-ecp384!
    keyingtries=%forever

    ## Please note the following line assumes you only have two tunnels
    ## in your Strongswan configuration file. This "mark" value must be
    ## unique and may need to be changed based on other entries in your
    ## configuration file.
    mark=100

    ## Uncomment the following line to utilize the script from the
    ##   "Automated Tunnel Healhcheck and Failover"
    ## section. Ensure that the integer after "-m" matches the "mark"
    ## value above, and <VPC CIDR> is replaced with the CIDR of your
    ## VPC (e.g. 192.168.1.0/24)
    leftupdown="/etc/ipsec.d/aws-updown.sh -ln Tunnel1 -ll $cgw_inside_ip_2/30 -lr $vpn_inside_ip_2/30 -m 100 -r ${cidr_aws}"

EOF

cat << EOF >> /etc/ipsec.secrets
$cgw_outside_ip $vgw_outside_ip_1 : PSK "$psk_1"
$cgw_outside_ip $vgw_outside_ip_2 : PSK "$psk_2"
EOF

ipsec restart

echo "END ---- 04-configure-vpn-tunnels.sh"
