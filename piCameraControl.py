#!/usr/bin/python
import picamera
import time
camera = picamera.PiCamera()
camera.capture('/home/pi/SCIAproject/sourceImages/'+time.strftime('%Y%m%d_%H%M')+'.jpg')
