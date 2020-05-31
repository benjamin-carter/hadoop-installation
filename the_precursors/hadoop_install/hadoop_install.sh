# Installing Hadoop/hdfs on Ubuntu 18.04

## install Java 
# See `java8_install.md`

## Configure password-less SSH
sudo apt-get install openssh-server openssh-client

## set up passwordless self ssh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


## download Hadoop
cd /home/opt
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz
tar -xzvf hadoop-2.8.5.tar.gz

## Create symbolic link (if you want)
ln -s hadoop-2.8.5 hadoop


## Adding 2_hadoop_install variables to `.~/bash_profile`
nano ~/.bash_profile

## 2_hadoop_install variables setup (write into `.bash_profile`)
export HADOOP_HOME=/home/opt/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

## make 2_hadoop_install and java variables available to system
source ~/.bash_profile

## Now let's edit our configurations
cd /home/opt/hadoop/etc/hadoop/

### edit `2_hadoop_install-env.sh`
nano hadoop-env.sh

export HADOOP_CONF_DIR=/home/opt/hadoop/etc/hadoop
export JAVA_HOME=/home/opt/jdk1.8.0_221

### edit `core-site.xml`
nano core-site.xml

<configuration>
  <property>
      <name>fs.defaultFS</name>
      <value>hdfs://localhost:9000</value>
  </property>
  <property>
      <name>hadoop.tmp.dir</name>
      <value>/home/opt/hadoop/hadoop_tmp</value>
  </property>
</configuration>


## Create 2_hadoop_install temp directory
mkdir /home/opt/hadoop/hadoop_tmp

### Edit `hdfs-site.xml`
> nano hdfs-site.xml

<configuration>
  <property>
      <name>dfs.replication</name>
      <value>1</value>
  </property>
  <property>
      <name>dfs.name.dir</name>
      <value>file:///home/hadoop/hdfs/namenode</value>
  </property>
  <property>
      <name>dfs.data.dir</name>
      <value>file:///home/hadoop/hdfs/datanode</value>
  </property>
</configuration>

## create datanode and namenode directory
mkdir -p /home/opt/hadoop/hdfs/namenode
mkdir -p /home/opt/hadoop/hdfs/datanode


### edit `mapred-site.xml`
cp mapred-site.xml.template mapred-site.xml
nano mapred-site.xml

<configuration>
  <property>
      <name>mapreduce.framework.name</name>
      <value>yarn</value>
  </property>
</configuration>


### edit `yarn-site.xml`
nano yarn-site.xml

<configuration>
  <property>
      <name>mapreduceyarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
  </property>
</configuration>


## Test 2_hadoop_install and hdfs variables
hadoop version
hdfs version


## Starting the Hadoop Cluster
hdfs namenode -format

## should have `status 0` at the end
start-dfs.sh
start-yarn.sh

# Test 2_hadoop_install / hdfs is working
hdfs dfs -mkdir /tmp
hadoop fs -mkdir /data
hdfs dfs -ls /
hadoop fs -ls /

# Congratulations, 2_hadoop_install/hdfs is installed.
# check UI
ip_address:50070