#!/bin/bash
echo "ahoj" > /home/pi/o1.txt;
minicom -S script1.txt -C output1.txt -D /dev/ttyUSB3 &
sleep 35;
minicom -S script2.txt -C output2.txt -D /dev/ttyUSB3 &
sleep 35;
sudo systemctl stop ModemManager.service; 
echo "ahoj" > /home/pi/o2.txt;
echo "Preparation complete";
sleep 3;
sudo qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode='online';
sudo ip link set wwan0 down;
echo 'Y' | sudo tee /sys/class/net/wwan0/qmi/raw_ip;
sudo ip link set wwan0 up;
sleep 1;
sudo qmicli -p -d /dev/cdc-wdm0 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="apn='internet.t-mobile.cz',ip-type=4" --client-no-release-cid;
sudo udhcpc -i wwan0;
echo "Done";
ping google.com -c 3
