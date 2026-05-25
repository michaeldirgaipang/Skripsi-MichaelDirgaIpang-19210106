/interface vlan
add interface=ether2 name=vlan_audio vlan-id=70
add interface=ether2 name=vlan_bahasa vlan-id=40
add interface=ether2 name=vlan_hotspot vlan-id=10
add interface=ether2 name=vlan_perpus vlan-id=50
add interface=ether2 name=vlan_sarpras vlan-id=60
add interface=ether2 name=vlan_tkj1 vlan-id=20
add interface=ether2 name=vlan_tkj2 vlan-id=30
/ip pool
add name=dhcp_pool1 ranges=192.168.10.2-192.168.10.62
add name=dhcp_pool2 ranges=192.168.10.66-192.168.10.94
add name=dhcp_pool3 ranges=192.168.10.98-192.168.10.126
add name=dhcp_pool4 ranges=192.168.10.130-192.168.10.142
add name=dhcp_pool5 ranges=192.168.10.146
add name=dhcp_pool6 ranges=192.168.10.150
add name=dhcp_pool7 ranges=192.168.10.154
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=vlan_hotspot lease-time=12h \
    name=dhcp1
add address-pool=dhcp_pool2 disabled=no interface=vlan_tkj1 lease-time=12h \
    name=dhcp2
add address-pool=dhcp_pool3 disabled=no interface=vlan_tkj2 lease-time=12h \
    name=dhcp3
add address-pool=dhcp_pool4 disabled=no interface=vlan_bahasa lease-time=12h \
    name=dhcp4
add address-pool=dhcp_pool5 disabled=no interface=vlan_perpus lease-time=12h \
    name=dhcp5
add address-pool=dhcp_pool6 disabled=no interface=vlan_sarpras lease-time=12h \
    name=dhcp6
add address-pool=dhcp_pool7 disabled=no interface=vlan_audio lease-time=12h \
    name=dhcp7
/queue tree
add disabled=yes max-limit=80M name=Download parent=ether2
add disabled=yes max-limit=80M name=Upload packet-mark="" parent=ether2
/queue type
add kind=pcq name="PCQ Download" pcq-classifier=dst-address,dst-port
add kind=pcq name="PCQ Upload" pcq-classifier=src-address,src-port
/queue simple
add max-limit=85M/85M name=SMKN1Tator_Line1 queue=default/default target=\
    192.168.10.0/24
add max-limit=30M/30M name=bw_vlan_hotspot parent=SMKN1Tator_Line1 queue=\
    "PCQ Upload/PCQ Download" target=vlan_hotspot
add max-limit=25M/25M name=bw_vlan_tkj1 parent=SMKN1Tator_Line1 queue=\
    "PCQ Upload/PCQ Download" target=vlan_tkj1
add max-limit=20M/20M name=bw_vlan_tkj2 parent=SMKN1Tator_Line1 queue=\
    "PCQ Upload/PCQ Download" target=vlan_tkj2
add max-limit=10M/10M name=bw_vlan_bahasa parent=SMKN1Tator_Line1 queue=\
    "PCQ Upload/PCQ Download" target=vlan_bahasa
/queue tree
add disabled=yes max-limit=80M name="Total Download" parent=global queue=\
    default
add disabled=yes max-limit=80M name="Total Upload" parent=global queue=\
    default
add disabled=yes limit-at=1M max-limit=60M name=Down-HotspotTKJ packet-mark=\
    "Hotspot TKJ" parent="Total Download"
add disabled=yes limit-at=2M max-limit=50M name=Down-LabTKJ1 packet-mark=\
    "Lab TKJ 1" parent="Total Download"
add disabled=yes limit-at=2M max-limit=40M name=Down-LabTKJ2 packet-mark=\
    "Lab TKJ 2" parent="Total Download"
add disabled=yes limit-at=2M max-limit=20M name=Down-LabBahasa packet-mark=\
    "Lab Bahasa" parent="Total Download"
add disabled=yes limit-at=1M max-limit=60M name=Up-HotspotTKJ packet-mark=\
    "Hotspot TKJ" parent="Total Upload"
add disabled=yes limit-at=2M max-limit=50M name=Up-LabTKJ1 packet-mark=\
    "Lab TKJ 1" parent="Total Upload"
add disabled=yes limit-at=2M max-limit=40M name=Up-LabTKJ2 packet-mark=\
    "Lab TKJ 2" parent="Total Upload"
add disabled=yes limit-at=2M max-limit=20M name=Up-LabBahasa packet-mark=\
    "Lab Bahasa" parent="Total Upload"
add disabled=yes limit-at=1M max-limit=60M name=down-hotspot packet-mark=\
    down_hotspot parent=Download queue="PCQ Download"
add disabled=yes limit-at=1M max-limit=60M name=upl-hotspot packet-mark=\
    upl-hotspot parent=Upload queue="PCQ Upload"
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.10.1/26 interface=vlan_hotspot network=192.168.10.0
add address=192.168.10.65/27 interface=vlan_tkj1 network=192.168.10.64
add address=192.168.10.97/27 interface=vlan_tkj2 network=192.168.10.96
add address=192.168.10.129/28 interface=vlan_bahasa network=192.168.10.128
add address=192.168.10.145/30 interface=vlan_perpus network=192.168.10.144
add address=192.168.10.149/30 interface=vlan_sarpras network=192.168.10.148
add address=192.168.10.153/30 interface=vlan_audio network=192.168.10.152
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.10.0/26 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.1
add address=192.168.10.64/27 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.65
add address=192.168.10.96/27 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.97
add address=192.168.10.128/28 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.129
add address=192.168.10.144/30 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.145
add address=192.168.10.148/30 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.149
add address=192.168.10.152/30 dns-server=8.8.8.8,192.168.1.1 gateway=\
    192.168.10.153
/ip dns
set servers=8.8.8.8
/ip firewall mangle
add action=mark-packet chain=forward disabled=yes dst-address=192.168.10.0/26 \
    new-packet-mark=down_hotspot passthrough=no
add action=mark-packet chain=forward disabled=yes new-packet-mark=upl-hotspot \
    passthrough=no src-address=192.168.10.0/26
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1 src-address=\
    192.168.10.0/24
/system identity
set name=MikroTik-Router
