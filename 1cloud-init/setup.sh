ssh-keygen -f id_rsa -t rsa
sed -i "s/SSHPUBKEY/$(cat id_rsa.pub)/" user-data.yaml
cloud-localds cloud-seed.img user-data.yaml meta-data.yaml
sudo chown ${USER}:libvirt-qemu cloud-seed.img
sudo cp cloud-seed.img /var/lib/libvirt/images/
[ ! -f alt-p11-cloud-x86_64.qcow2 ] && wget https://ftp.altlinux.org/pub/distributions/ALTLinux/p11/images/cloud/x86_64/alt-p11-cloud-x86_64.qcow2
sudo chown ${USER}:libvirt-qemu alt-p11-cloud-x86_64.qcow2 
sudo cp alt-p11-cloud-x86_64.qcow2 /var/lib/libvirt/images/
sudo virsh net-define net.xml
