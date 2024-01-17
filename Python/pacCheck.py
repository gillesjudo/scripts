#!/usr/bin/env python3
import subprocess

if __name__ =="__main__":
    package = input("What package do you want checked? ")

def package_checker(package):
    find=['find', '/usr/sbin', '/usr/bin', '/bin', '-type', 'f', '-name', package]
    install=['sudo', 'apt', 'install', package, '-y']
    find_output=subprocess.run(find, capture_output=True, text=True)
    print(find_output.stdout.strip())
    if find_output.stdout.strip() == '':
       print("It does not seem like", package, "is installed, will install now.")
       subprocess.run(install)
    else:
        return print(package, "is present.")


