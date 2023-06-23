

sudo virt-intall \
--name ubuntuLabtest-vm \
--vcpus 1 \
--memory 4096 \
--cdrom /home/gillescastro/ubuntu-20.04.6-desktop-amd64.iso \
--disk size=25 \
--os-variant ubuntu20 \
--network bridge br0 \
--network network=default
