# install SBT ON UBUNTU/MAC

# download sbt zip
cd /opt
sudo chown $USER .
wget https://piccolo.link/sbt-1.2.7.zip

# unzip sbt
unzip sbt-1.2.7.zip

# set SBT HOME & Add sbt to path
echo SBT_HOME=/opt/sbt  >>  ~/.bash_profile
echo "export PATH=\${PATH}:\$SBT_HOME/bin" >>  ~/.bash_profile

# restart bash file
source ~/.bash_profile
