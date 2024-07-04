##########

Minikube Setup:

###    Install Dependencies

sudo yum install epel-release -y

sudo yum install conntrack wget httpd-tools redis jq socat -y

sudo yum install python2 python3 net-tools keyutils.x86_64 java-1.8.0-openjdk-devel.x86_64  -y

sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

sudo setenforce 0

### Install Minikube

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube 

### Install Helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

### Install Docker

sudo yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo -y

sudo yum-config-manager --enable docker-ce-test

sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

sudo systemctl start docker && sudo systemctl enable docker

### Install Kubectl

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version --client

### updating network

grep -q 'net.bridge.bridge-nf-call-iptables = 1' /etc/sysctl.conf || echo "net.bridge.bridge-nf-call-iptables = 1" | sudo tee -a /etc/sysctl.conf


### Start Minikube from non root user
sudo /usr/local/bin/minikube start --driver=none  --bootstrapper=kubeadm --extra-config=scheduler.address=0.0.0.0 --extra-config=controller-manager.address=0.0.0.0 --kubernetes-version=v1.23.4

sudo mv /root/.kube /root/.minikube $HOME
   
sudo chown -R $USER:$USER $HOME/.kube $HOME/.minikube

sed "s@/root@"$HOME"@g" ~/.kube/config > tmp.$$; mv tmp.$$ ~/.kube/config

chmod 600 ~/.kube/config

sudo systemctl enable kubelet.service

################

Deployment

################

git clone https://github.com/Vengatesh-m/qa-test

cd qa-test

kubectl apply -f frontend-deployment.yaml

kubectl apply -f backend-deployment.yaml

kubectl get pods -o wide

kubectl get svc

kubectl edit svc frontend-service #### Change type to NodePort from LoadBalancer

kubectl get svc

curl http://localhost:31115

Output:

![image](https://github.com/npallegoud/Minikube_deploy/assets/76092758/7119428d-220d-4c06-897d-7418f7970c76)


From browser

http://<IP of the Machine>:31115

Output:

![image](https://github.com/npallegoud/Minikube_deploy/assets/76092758/cbf505db-76f4-4ce3-b4b2-2f254bb62e72)


