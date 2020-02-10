import socket
import os, os.path
import time
from collections import deque
import json
from neopixel import *
import argparse
from wakeup import wake_up

LED_COUNT      = 60      # Number of LED pixels.
LED_PIN        = 18      # GPIO pin connected to the pixels (18 uses PWM!).
LED_FREQ_HZ    = 800000  # LED signal frequency in hertz (usually 800khz)
LED_DMA        = 10      # DMA channel to use for generating signal (try 10)
LED_BRIGHTNESS = 200     # Set to 0 for darkest and 255 for brightest
LED_INVERT     = False   # True to invert the signal (when using NPN transistor level shift)
LED_CHANNEL    = 0       # set to '1' for GPIOs 13, 19, 41, 45 or 53

def show_color(strip, event):
    print('color received')
    color = Color(event['data']['g'], event['data']['r'], event['data']['b']) # GRB
    for led in range(LED_COUNT):
        strip.setPixelColor(led, color)

    strip.show()

def process_event(event, strip):
    event = json.loads(event)
    event_type = event['type']

    if event_type == 'color':
        show_color(strip, event)
    if event_type == 'wake_up':
        wake_up(strip)

sock = "/tmp/sock"
if os.path.exists(sock):
    os.remove(sock)

server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
server.bind(sock)
strip = Adafruit_NeoPixel(LED_COUNT, LED_PIN, LED_FREQ_HZ, LED_DMA, LED_INVERT, LED_BRIGHTNESS, LED_CHANNEL)
strip.begin()
try:
    while True:
        server.listen(1)
        conn, addr = server.accept()
        datagram = conn.recv(1024)
        print(datagram)
        process_event(datagram, strip)

finally:
    print("Shutting down...")
    server.close()
    os.remove(sock)

