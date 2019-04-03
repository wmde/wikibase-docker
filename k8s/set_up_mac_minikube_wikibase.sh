#!/bin/bash
# usage: ./set_me_up.sh


echo Setting up minikube environment for you

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

brew cask list virtualbox > /dev/null 2>&1
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "virtualbox not installed, so installing now"
    brew cask install virtualbox
fi

echo "Checking if minikube is installed"
brew cask list minikube > /dev/null 2>&1
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "minikube not installed, so installing now"
    brew cask install minikube
fi

echo "Checking if kubectl is installed"
brew list kubernetes-cli > /dev/null 2>&1
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "kubectl not installed, so installing now"
    brew install kubernetes-cli
fi

echo "Checking if dnsmasq is installed"
brew list dnsmasq > /dev/null 2>&1
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "dnsmasq not installed, so installing now"
    brew install dnsmasq
fi

echo "Setting bash kubectl completion"
export ASDF_KUBECTL_VERSION=1.13.4
kubectl completion bash > $(brew --prefix)/etc/bash_completion.d/kubectl

echo "Setting kubectl KUBECONFIG"
export KUBECONFIG="$HOME/.kube/kubeconfig.minikube.yaml";

echo "Checking minikube status"
minikube status > /dev/null 2>&1
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Minikube is not yet running, so starting it"
    minikube start --memory 7168 --disk-size 20g --extra-config=apiserver.authorization-mode=RBAC
    minikube addons enable ingress
fi

echo "Getting minikube ip address"
# brew install dnsmasq
MINIKUBE_IP="$(minikube ip)"
echo Minikube IP is $MINIKUBE_IP
echo Setting local docker build context to minikube
eval "$(minikube docker-env)"

echo "Setting dnsmasq to resolve minikube ingress"

grep -Fxq 'bind-interfaces' /usr/local/etc/dnsmasq.conf
retVal=$?
if [ $retVal -ne 0 ]; then
  echo 'bind-interfaces' >> /usr/local/etc/dnsmasq.conf
fi

grep -Fxq 'listen-address=127.0.0.1' /usr/local/etc/dnsmasq.conf
retVal=$?
if [ $retVal -ne 0 ]; then
  echo 'listen-address=127.0.0.1' >> /usr/local/etc/dnsmasq.conf
fi

RESOLVE_MINIKUBE_INGRESS="address=/ingress.local/${MINIKUBE_IP}"
grep -Fxq "${RESOLVE_MINIKUBE_INGRESS}" /usr/local/etc/dnsmasq.conf
retVal=$?
if [ $retVal -ne 0 ]; then
  #remove outdated minikube ip address references, if any
  sed -i.bak '/^address=\/ingress.local/d' /usr/local/etc/dnsmasq.conf
  rm /usr/local/etc/dnsmasq.conf.bak
  echo "${RESOLVE_MINIKUBE_INGRESS}" >> /usr/local/etc/dnsmasq.conf
fi

echo "Setting local DNS resolution of ingress.local domain (might need password)"
sudo mkdir -p /etc/resolver/
sudo tee /etc/resolver/ingress.local > /dev/null <<'EOF'
nameserver 127.0.0.1
domain ingress.local
search ingress.local default.ingress.local
options ndots:5
EOF

echo "Restarting DNS and flushing caches"
sudo brew services restart dnsmasq

sudo killall -HUP mDNSResponder; sleep 2


CURRENT_DIRECTORY="$(basename "$PWD")"
if [ "$CURRENT_DIRECTORY" == "k8s" ]; then
    echo "Attempting to apply kubernetes manifests from current directory"
    kubectl apply -f .
else
   echo "Attempting to apply manifests from ${SCRIPT_DIR} directory"
   kubectl apply -f "${SCRIPT_DIR}"
fi
echo "When complete, browse http://wikibase.ingress.local/wiki/Main_Page and  http://wdqs.ingress.local/"
echo "This might take a while. Checking progress:"
./wait_for.sh pod wikibase-0 -n wikibase
./wait_for.sh pod wdqs-0 -n wikibase
echo "Opening ingress locations in the browser"
open http://wikibase.ingress.local/wiki/Main_Page
open http://wdqs.ingress.local/
