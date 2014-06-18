set -e
set -x

if [ -f /etc/disk_added_date ]
then
   echo "disk already added so exiting."
   exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

pvcreate /dev/sdb1
vgextend VolGroup /dev/sdb1
lvextend -L +5G /dev/VolGroup/lv_root
resize2fs /dev/VolGroup/lv_root

date > /etc/disk_added_date