
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no

/interface vlan
add interface=ether2 name=vlan_audio vlan-id=70
add interface=ether2 name=vlan_bahasa vlan-id=40
add interface=ether2 name=vlan_hotspot vlan-id=10
add interface=ether2 name=vlan_perpus vlan-id=50
add interface=ether2 name=vlan_sarpras vlan-id=60
add interface=ether2 name=vlan_tkj1 vlan-id=20
add interface=ether2 name=vlan_tkj2 vlan-id=30

/ip pool
add name=pool-hotspot ranges=192.168.10.2-192.168.10.62
add name=pool-tkj1 ranges=192.168.10.66-192.168.10.94
add name=pool-tkj2 ranges=192.168.10.98-192.168.10.126
add name=pool-bahasa ranges=192.168.10.130-192.168.10.142
add name=pool-perpus ranges=192.168.10.146
add name=pool-sarpras ranges=192.168.10.150
add name=pool-audio ranges=192.168.10.154

/queue simple
add max-limit=85M/85M name=SMKN1Tator_Line1 target=192.168.10.0/24

/queue type
add kind=pcq name=PCQ-Upload pcq-classifier=src-address
add kind=pcq name=PCQ-Download pcq-classifier=dst-address

/queue simple
add max-limit=30M/30M name=bw_vlan_hotspot parent=SMKN1Tator_Line1 queue=PCQ-Upload/PCQ-Download target=vlan_hotspot
add max-limit=25M/25M name=bw_vlan_tkj1 parent=SMKN1Tator_Line1 queue=PCQ-Upload/PCQ-Download target=vlan_tkj1
add max-limit=20M/20M name=bw_vlan_tkj2 parent=SMKN1Tator_Line1 queue=PCQ-Upload/PCQ-Download target=vlan_tkj2
add max-limit=10M/10M name=bw_vlan_bahasa parent=SMKN1Tator_Line1 queue=PCQ-Upload/PCQ-Download target=vlan_bahasa

/ip address
add address=192.168.10.1/26 comment=HOTSPOT-TKJ interface=vlan_hotspot network=192.168.10.0
add address=192.168.10.65/27 comment=LAB-TKJ1 interface=vlan_tkj1 network=192.168.10.64
add address=192.168.10.97/27 comment=LAB-TKJ2 interface=vlan_tkj2 network=192.168.10.96
add address=192.168.10.129/28 comment=LAB-BAHASA interface=vlan_bahasa network=192.168.10.128
add address=192.168.10.145/30 comment=PERPUSTAKAAN interface=vlan_perpus network=192.168.10.144
add address=192.168.10.149/30 comment=SARPRAS interface=vlan_sarpras network=192.168.10.148
add address=192.168.10.153/30 comment=AUDIO-VIDEO interface=vlan_audio network=192.168.10.152

/ip cloud
set ddns-enabled=yes update-time=yes

/ip dhcp-client
add interface=ether1 name=client1

/ip dhcp-server
add address-pool=pool-hotspot interface=vlan_hotspot name=dhcp-hotspot
add address-pool=pool-tkj1 interface=vlan_tkj1 name=dhcp-tkj1
add address-pool=pool-tkj2 interface=vlan_tkj2 name=dhcp-tkj2
add address-pool=pool-bahasa interface=vlan_bahasa name=dhcp-bahasa
add address-pool=pool-perpus interface=vlan_perpus name=dhcp-perpus
add address-pool=pool-sarpras interface=vlan_sarpras name=dhcp-sarpras
add address-pool=pool-audio interface=vlan_audio name=dhcp-audio

/ip dhcp-server network
add address=192.168.10.0/26 dns-server=8.8.8.8 gateway=192.168.10.1
add address=192.168.10.64/27 dns-server=8.8.8.8 gateway=192.168.10.65
add address=192.168.10.96/27 dns-server=8.8.8.8 gateway=192.168.10.97
add address=192.168.10.128/28 dns-server=8.8.8.8 gateway=192.168.10.129
add address=192.168.10.144/30 dns-server=8.8.8.8 gateway=192.168.10.145
add address=192.168.10.148/30 dns-server=8.8.8.8 gateway=192.168.10.149
add address=192.168.10.152/30 dns-server=8.8.8.8 gateway=192.168.10.153

/ip dns
set allow-remote-requests=yes servers=8.8.8.8

/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1

/system identity
set name=MikroTik-Router
