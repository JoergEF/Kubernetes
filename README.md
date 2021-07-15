# Kubernetes

Ein Kubernetes-Multinode-Cluster mit Ansible erstellt.

#### Benutzung:

```bash
sudo apt update && sudo apt -y install ansible ansible-lint make vagrant git
git clone https://github.com/JoergEF/Kubernetes
cd Kubernetes
make

# Nachdem make erfolgreich beendet ist:
[ -d ~/.kube ] || mkdir -p ~/.kube
scp -P 2222 vagrant@127.0.0.1:/home/vagrant/.kube/config ~/.kube/config
```
##### Das Passwort lautet 'vagrant'
