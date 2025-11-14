[ ! -f id_rsa ] && ssh-keygen -f id_rsa -t rsa
ssh "s|SSHPUBKEY|`cat id_rsa.pub`|" user-data.yaml.in > user-data.yaml
cloud-localds cloud-seed.img user-data.yaml meta-data.yaml
sudo cp cloud-seed.img /var/lib/libvirt/images/
sudo chown ${USER}:libvirt-qemu /var/lib/libvirt/images/cloud-seed.img
[ ! -f alt-p11-cloud-x86_64.qcow2 ] && wget https://ftp.altlinux.org/pub/distributions/ALTLinux/p11/images/cloud/x86_64/alt-p11-cloud-x86_64.qcow2
sudo cp alt-p11-cloud-x86_64.qcow2 /var/lib/libvirt/images/
sudo chown ${USER}:libvirt-qemu /var/lib/libvirt/images/alt-p11-cloud-x86_64.qcow2 
sudo virsh net-create net.xml
sudo virt-install --name 11cloud-1 \
    --ram 2048 --vcpus 2 \
    --disk path=/var/lib/libvirt/images/alt-p11-cloud-x86_64.qcow2 \
    --disk path=/var/lib/libvirt/images/cloud-seed.img,format=raw \
    --os-variant linux2024 \
    --virt-type kvm \
    --network network=cl,model=virtio \
    --import
