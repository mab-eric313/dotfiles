import pystray, subprocess, os
from PIL import Image

def get_home_dir():
    return os.getenv('HOME')

def get_image_path():
    return f"{get_home_dir()}/.config/qtile/batteryLimit.jpg"

def event_click(icon, query):
    commands = {
        "set to 100%": "echo 100 > /sys/class/power_supply/BAT0/charge_control_end_threshold",
        "set to 80%": "echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold",
        "set to 60%": "echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold"
    }
    
    if str(query) in commands:
        subprocess.run(["pkexec", "bash", "-c", commands[str(query)]], shell=False)
    elif str(query) == "Exit":
        icon.stop()

def create_icon():
    try:
        image = Image.open(get_image_path())
    except Exception as e:
        print(f"Error loading image: {e}")
        return None
    
    return pystray.Icon("batteryLimit", image, "Battery Limit", menu=pystray.Menu(
        pystray.MenuItem("set to 100%", event_click),
        pystray.MenuItem("set to 80%", event_click),
        pystray.MenuItem("set to 60%", event_click),
        pystray.MenuItem("Exit", event_click)
    ))

if __name__ == "__main__":
    icon = create_icon()
    if icon:
        icon.run()
