#Install libs
yum install gcc perl-devel -y

#Create dirs
mkdir /opt/collectd/
mkdir /var/lib/zabbix/

#Install Collectd
curl -o /opt/collectd/ --progress https://collectd.org/files/collectd-5.5.0.tar.gz | tar xz
cd /opt/collectd/collectd-* && make all install

#Install Configuration
git clone https://github.com/raboy/configurations.git 
cp configurations/collectd/files/collectd.conf  /etc/collectd.conf
cp configurations/collectd/files/iostat_collectd_plugin.rb /var/lib/zabbix/iostat_collectd_plugin.rb
cp configurations/collectd/files/tcp.sh /var/lib/zabbix/tcp.sh
cp /opt/collectd/collectd-*/contrib/redhat/init.d-collectd /etc/init.d/collectd
chmod +x /etc/init.d/collectd
chmod +x /var/lib/zabbix/*

#Run Collectd daemon
sudo ln --symbolic /opt/collectd/sbin/collectd /usr/sbin/collectd
sudo ln --symbolic /opt/collectd/sbin/collectdmon /usr/sbin/collectdmon
service collectd start
