#

/interface bridge
add name=bridge-vlan vlan-filtering=yes

/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
set [ find default-name=ether7 ] disable-running-check=no
set [ find default-name=ether8 ] disable-running-check=no

/interface bridge port
add bridge=bridge-vlan interface=ether1
add bridge=bridge-vlan interface=ether2 pvid=10
add bridge=bridge-vlan interface=ether3 pvid=20
add bridge=bridge-vlan interface=ether4 pvid=30
add bridge=bridge-vlan interface=ether5 pvid=40
add bridge=bridge-vlan interface=ether6 pvid=50
add bridge=bridge-vlan interface=ether7 pvid=60
add bridge=bridge-vlan interface=ether8 pvid=70

/interface bridge vlan
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether2 vlan-ids=10
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether3 vlan-ids=20
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether4 vlan-ids=30
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether5 vlan-ids=40
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether6 vlan-ids=50
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether7 vlan-ids=60
add bridge=bridge-vlan tagged=bridge-vlan,ether1 untagged=ether8 vlan-ids=70


/system identity
set name="Mikrotik Switch"
