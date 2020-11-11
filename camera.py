from time import sleep
from gpiozero import MotionSensor
from picamera import PiCamera
import datetime

camera = PiCamera()
pir = MotionSensor(4)
film =0
count = 0

while True:
	while pir.motion_detected == True:
		print("beweging")
		if film == 0:
			camera.start_recording("/mnt/USBdrive/videos" + ":%Y-%m-%d %H:%M}".format(datetime.datetime.now())+".h264")
			print("filmend begonnen")
			film = 1
		if film == 1:
			sleep(1)
			count = count + 1
			print ("film is al ", count , "lang")
		if count == 1 and film == 1:
			camera.stop_recording()
			print ("filmen gestopt: film is 5 minuten lang")
			camera.start_recording("/mnt/USBdrive/videos" + ":%Y-%m-%d %H:%M}".format(datetime.datetime.now())+".h264")
			print("filmen opnieuw begonnen")
			count  = 0
	if pir.motion_detected == False:
		print("geen beweging")
		sleep (1)
		if film == 1:
			camera.stop_recording()
			print("filmen gestopt: geen beweging")
			film = 0
			count = 0

