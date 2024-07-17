import subprocess
from typing import List

from Config import Config, Package
from Colors import *


def yay_cmd(cmd: List[str]):
    print(f"{COLOR_CYAN}proposed command{COLOR_NC}: " + " ".join(cmd))
    i = input(f"{COLOR_CYAN}Run?{COLOR_NC} [y/N] ")
    if i.lower() == "y":
        print(" ".join(cmd))
        p = subprocess.Popen(cmd)
        p.communicate()
        if p.returncode != 0:
            raise Exception(f"Yay error ({p.returncode}).")

def yay_install(packages: List[Package]):
    if len(packages) == 0:
        print("Nothing to do.")
        return
    yay_cmd(['yay', '-Sy', *[str(p) for p in packages]])


def yay_remove(packages: List[Package]):
    if len(packages) == 0:
        print("Nothing to do.")
        return
    yay_cmd(['yay', '-R', *[p.name for p in packages]])


def yay_read_pkg_state(c: Config):
    cmd = ['yay', '-Q']
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    if p.returncode != 0:
        raise Exception(f"yay error: {err.decode()}")

    state = {}

    for line in out.decode().splitlines():
        parts = line.split(" ")
        if len(parts) != 2:
            raise Exception(f"yay output confusing: {line}")

        name = parts[0]
        ver = parts[1]
        state[name] = ver

    for group in c.groups:
        for package in c.groups[group].packages.values():
            if package.name in state:
                package.installed_version = state[package.name]
