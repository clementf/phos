#!/usr/bin/env python3
import time
from neopixel import *
import argparse

def christmas(strip):
    green = Color(107,6,23)
    red = Color(0, 240, 0)
    gold = Color(77, 107, 0)

    middle = strip.numPixels() / 2
    inverter = 1

    for total in range(1, 10):
        for times in range(1, 10):
            for i in range(inverter, strip.numPixels(), 4):
                strip.setPixelColor(i, green)

            for i in range(inverter - 1, strip.numPixels(), 4):
                strip.setPixelColor(i, red)

            strip.show()
            inverter = (inverter) % 2 + 1
            time.sleep(1)


        for i in range(middle - 10, middle + 10):
            if i % inverter == 0: strip.setPixelColor(i, red)

        for i in range(0, 6, inverter):
            strip.setPixelColor(i, gold)

        for i in range(strip.numPixels() - 6, strip.numPixels()):
            if i % inverter == 0: strip.setPixelColor(i, gold)

        for i in range(6, middle - 11):
            if i % inverter == 0: strip.setPixelColor(i, green)

        for i in range(middle + 11, strip.numPixels() - 7):
            if i % inverter == 0: strip.setPixelColor(i, green)

        strip.show()
        time.sleep(20)

    for i in range(0, strip.numPixels()):
        strip.setPixelColor(i, Color(0,0,0))

    strip.show()
