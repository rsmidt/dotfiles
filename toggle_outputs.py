#!/usr/bin/env python3

import i3ipc
import sys

OUTPUT_NAME = 'HDMI-A-1'

i3 = i3ipc.Connection()

def find_hdmi_device():
    outputs = i3.get_outputs()

    for output in outputs:
        if output.name == OUTPUT_NAME:
            return output

    return None

def toggle_device_state(device):
    if device['active'] is False:
        i3.command(f"output {device['name']} enable")
    else:
        i3.command(f"output {device['name']} disable")

output = find_hdmi_device()

if output is None:
    print(f"Output with name: {OUTPUT_NAME} could not be found.")
    sys.exit()

toggle_device_state(output)
