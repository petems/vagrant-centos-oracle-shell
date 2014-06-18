
yum install libaio bc flex unzip -y

dd if=/dev/zero of=/extraswap bs=1M count=2048

/sbin/mkswap /extraswap && /sbin/swapon /extraswap

/usr/bin/unzip -q /vagrant/oracle/oracle*.rpm.zip -d /vagrant/oracle

/bin/rpm -ivh /vagrant/oracle/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm
yum install /vagrant/oracle/oracle-instantclient12* -y

/etc/init.d/oracle-xe configure responseFile=/vagrant/oracle/xe.rsp || true

/bin/echo 'source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh' >> /home/vagrant/.bash_profile

/bin/echo 'source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh' >> /root/.bash_profile

service iptables stop

ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus system/manager@localhost < /vagrant/oracle/set_listener.sql