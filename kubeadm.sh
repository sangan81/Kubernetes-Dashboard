sudo su
apt-get update
apt-get install docker.io
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt install kubeadm=1.21.0-00 kubectl=1.21.0-00 kubelet=1.21.0-00 -y