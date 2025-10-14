[ ! -f id_rsa ] && ssh-keygen -f id_rsa -t rsa
awk '{ getline key < "id_rsa.pub"; gsub("SSHPUBKEY", key); print > "user-data.yaml" }' user-data.yaml.in
cloud-localds cloud-seed.img user-data.yaml meta-data.yaml
sudo cp cloud-seed.img /var/lib/libvirt/images/
sudo chown ${USER}:libvirt-qemu /var/lib/libvirt/images/cloud-seed.img
[ ! -f alt-p11-cloud-x86_64.qcow2 ] && wget https://ftp.altlinux.org/pub/distributions/ALTLinux/p11/images/cloud/x86_64/alt-p11-cloud-x86_64.qcow2
sudo cp alt-p11-cloud-x86_64.qcow2 /var/lib/libvirt/images/
sudo chown ${USER}:libvirt-qemu /var/lib/libvirt/images/alt-p11-cloud-x86_64.qcow2 
sudo virsh net-define net.xml
