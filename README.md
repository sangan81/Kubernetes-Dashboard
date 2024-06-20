Hands-On: Kubernetes Dashboard

Step 1: 

Launch 2 instances with the following configuration: ubuntu 20.04 ami,
t2.medium, sg: all traffic. ubuntu 20.04 ami, t2.micro , sg: all traffic
To Install Kubernetes use the following commands:

On Master and Worker node:

sudo su
apt-get update
apt-get install docker.io -y
service docker restart
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key
add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main"
>/etc/apt/sources.list.d/kubernetes.list
apt-get update
apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 –y

Step 2: On both master and worker nodes run the above command:

2.1. sudo su
2.2. create a script file kubernetes.sh
2.3. to execute the script file: bash kubernetes.sh

On Master:

Step 3:

Creating cluster:

Initializing kubeadm on master using:

kubeadm init --pod-network-cidr=192.168.0.0/16

Copy the token and paste it into the worker node

Step 4:

On Master:

We need to run the below commands:

exit
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

Note: In case we want to retrieve the join token use the below-mentioned
command.

kubeadm token create --print-join-command

Step 5:

On Master:

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply –f
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.
49.0/deploy/static/provider/baremetal/deploy.yaml

To list all nodes :

kubectl get nodes

Our Kubernetes installation and configuration is complete.

It shows the nodes but the status is not ready
because we have not installed the network plugin.

To install network plugin, run the below commands:

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controllerv0.49.0/deploy/static/provider/baremetal/deploy.yaml

Check the nodes for its state after installing network plugins.

kubectl get nodes

Thus, we have successfully installed Kubernetes.

Step 6:

Run the below command tocreate a dashboard:

kubectl apply -f
https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommen
ded.yaml

Then edit the service:

kubectl edit service kubernetes-dashboard -n kubernetes-dashboard

Note: We need to change the type from ClusterIP to NodePort. The below given
image contains the modified service file.
 
Note: The editor used is vim. Therefore to save and exit we need to press ESC
and then: wq

kubectl get svc -n kubernetes-dashboard

Step 7:

Now go to a browser and paste the ip along with the port

https://<ip-of-master>

We need to click on Advance option to access the webpage

Click on the Proceed option to open the dashboard
 
Step 8:

We need to create a service account:

To create service account run the below command:

kubectl create serviceaccount cluster-admin-dashboard-sa

To bind clusterAdmin role to the service account use the below command:

kubectl create clusterrolebinding cluster-admin-dashboard-sa \
--clusterrole=cluster-admin \
--serviceaccount=default:cluster-admin-dashboard-sa

To parse the token run the below command:

TOKEN=$(kubectl describe secret $(kubectl -n kube-system get secret | awk '/^clusteradmin-
dashboardsa-token-/{print $1}') | awk '$1=="token:"{print $2}')

Then we need to run the below command:

echo $TOKEN

Copy the token and paste in the Kubernetes dashboard.

Then click on Sign in. The dashboard is created.

 

