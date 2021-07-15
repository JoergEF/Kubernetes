# Ceph Cluster erstellen

### Achtung: mindestens 3 Worker-Nodes nötig

1. Vagrantfile um zusätzliche Datenträger erweitern (Zeile 53 - 56)
2. Im Terminal:  (Makefile erweitert (Zeilen 10 - 11))
    ```bash
    make [fresh]
    ```
3. im Terminal:
    ```bash
    [ -d ~/.kube ] || mkdir -p ~/.kube
    scp -P 2222 vagrant@127.0.0.1:/home/vagrant/.kube/config ~/.kube/config
    ```
4. neues Dashboard:
    ```bash
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
    kubectl apply -f kubernetes-dashboard-service-np.yaml
    kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
    ```
5. mit Secret am Dashboard anmelden (optional):

    https://192.168.100.11:30002
6. Ceph-Cluster installieren:

    Anleitung: https://rook.io/docs/rook/v1.6/ceph-quickstart.html
    ```bash
    cd ~/git
    git clone https://github.com/rook/rook.git
    cd rook/cluster/examples/kubernetes/ceph
    kubectl create -f crds.yaml -f common.yaml -f operator.yaml
    kubectl create -f cluster.yaml
    cd ~/git/Kubernetes
    kubectl create -f ceph-cluster/10\ -\ rook-toolbox.yaml
    kubectl -n rook-ceph rollout status deploy/rook-ceph-tools
    ```
7. Cluster überprüfen
    ```bash
    kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
    ceph status
    ceph osd status
    ```

    mit ```<STRG>+<D>``` verlassen
8. Block-Storage anlegen
    ```bash
    kubectl create -f ceph-cluster/20\ -\ ClusterStorageClass.yaml
    ```

##### Ab sofort steht der ceph-Speicher als Blockstorage für PersistentVolumeClaims zur Verfügung. Als StorageClass muss dafür rook-ceph-block angegeben werden.

```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-claim
  labels:
    app: my-app
spec:
  storageClassName: rook-ceph-block
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
```