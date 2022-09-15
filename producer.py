                                                                           producer.py
from kafka import KafkaProducer
from datetime import datetime
import time
from dronekit import connect, VehicleMode

producer = KafkaProducer(bootstrap_servers = 'ptommy.com:29092')
vehicle = connect('/dev/ttyACM1', wait_ready=True)
vehicle.mode = VehicleMode("STABILIZE")



#while True:
        #print("\n\nType \"quit\" to exit")
        #print("Enter message to be sent:")
        #msg = input()
        #if msg == "quit":
        #       print("Exiting...")
        #       break

msg = '{' + "vyska:" + str(vehicle.attitude) + ",time:" + str(datetime.timestamp(datetime.now())) + '}'
#msg = "c"
print(msg)
producer.send('topic1',value=msg.encode('utf-8'))
print("Sending msg \"{}\"".format(msg))
print("Message sent!")
time.sleep(5)
