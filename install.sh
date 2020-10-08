cd $(dirname $0)
BASEDIR=$(pwd -P)
apt-get install -y openjdk-8-jdk-headless git mc libpigpio-dev libpigpio1

#install server
cd $(BASEDIR)
javac server/*.java
ln -s /usr/bin/java /usr/bin/serverjava

if grep -Fq "serverjava" /etc/rc.local 
then
echo Already installed in rc.local
else
sed -i "s#^exit 0#cd ${BASEDIR}\nserverjava server/Main &\n\nexit 0#g" /etc/rc.local
fi

#install boebot library
cd /home/pi
git clone https://github.com/TiBoebot/BotBotLib.git /home/pi/BoeBotLib
cd /home/pi/BoeBotLib
/home/pi/BoeBotLib/build

cp /home/pi/PIGPIO/libpigpio.so /home/pi/BoeBotLib
mkdir /home/pi/upload
chmod 777 /home/pi/upload
chown pi:pi /home/pi/upload