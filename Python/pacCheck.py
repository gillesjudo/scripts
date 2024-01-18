#!/usr/bin/env python3
import subprocess

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


if __name__ =="__main__":
    package = str(input("What package do you want checked? "))
    pack_array = [pack.strip() for pack in package.split(',')]
    for pack in pack_array:
        package_checker(pack)

