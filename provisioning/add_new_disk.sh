set -e
set -x

if [ -f /etc/disk_added_date ]
then
   echo "disk already added so exiting."
   exit 0
fi

pvcreate /dev/sdb
vgextend VolGroup /dev/sdb
lvextend -L +5G /dev/VolGroup/lv_root
resize2fs /dev/VolGroup/lv_root

date > /etc/disk_added_date
