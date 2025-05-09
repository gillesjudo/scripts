#!/usr/bin/env python3
import subprocess

def package_checker(package):
    find=['find', '/usr/sbin', '/usr/bin', '/bin', '-name', package]
    install=['sudo', 'apt', 'install', package, '-y']
    #The Find and install variables are created to be input into the subprocess.run module
    #Both are the command syntax I will be running later
    print('[+] Checking Necessary Packages and dependencies.')
    if isinstance(package,list):
        for pack in package:
            find[5] = pack.strip()
            install[3] = pack.strip()
            find_output=subprocess.run(find, capture_output=True, text=True)
            #print(find_output.stdout.strip())
            if find_output.stdout.strip() == '':
                print("[+] It does not seem like", pack, "is installed, will install now.")
                subprocess.run(install)
            else:
                print("[+]",pack, "is present.")
    else:
        find_output=subprocess.run(find, capture_output=True, text=True)
        print(find_output.stdout.strip())
        if find_output.stdout.strip() == '':
            print("[+] It does not seem like", package, "is installed, will install now.")
            subprocess.run(install)
        else:
            return print(package, "[+] is present.")

'''if the script importing this function creates an array for the
 variable package we use the above for loop to iterate through all of
 the strings.
''' 
if __name__ =="__main__":
    package = str(input("What package do you want checked? "))
    pack_array = [ pack.strip() for pack in package.split(',')]
    for pack in pack_array:
        package_checker(pack)

