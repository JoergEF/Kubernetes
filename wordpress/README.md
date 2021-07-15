# Wordpress im k8s-Cluster mit 3 Instanzen
## mit lokalem Storage

1. nötige Verzeichnisse anlegen:
    ```bash
    vagrant ssh k8s-n-1
    sudo mkdir -p /mnt/{wp, my}
    exit
    vagrant ssh k8s-n-2
    sudo mkdir -p /mnt/{wp, my}
    exit
    vagrant ssh k8s-n-3
    sudo mkdir -p /mnt/{wp, my}
    exit
    ```
2. wordpress/kustomization.yaml anpassen:

    _in Zeile 6 ```<ENTER>``` und dann zusätzlich einfügen:_

    ```- persistentvolume.yaml```

    _Speichern nicht vergessen!_
3. wordpress/mysql-deployment anpassen:

    _Zeile 22 ff. (einfügen)_

    ```yaml
    storageClassName = manual
    capacity:
        storage: 20Gi
    hostPath:
    path: "/mnt/data/my"
    ```
4. wordpress/wordpress-deployment anpassen:

    _Zeile 22 ff. (einfügen)_

    ```yaml
    storageClassName = manual
    capacity:
        storage: 20Gi
    hostPath:
    path: "/mnt/data/wp"
    ```

5. anwenden:
    ```bash
    kubectl apply -k wordpress/.

---
## mit Cluster - Storage (ceph)

1. ceph-Cluster installieren
2. wordpress/kustomization.yaml anpassen:

    _Zeile 6 löschen_
3. wordpress/mysql-deployment anpassen:

    _Zeile 22 ändern:_

    ```yaml
    storageClassName = rook-ceph-block
    ```

    _ab Zeile 23 folgendes löschen:_
    ```yaml
    capacity:
        storage: 20Gi
    hostPath:
    path: "/mnt/data/my"
    ```
4. wordpress/wordpress-deployment anpassen:

    _Zeile 22 ändern:_

    ```yaml
    storageClassName = rook-ceph-block
    ```

    _ab Zeile 23 folgendes löschen:_
    ```yaml
    capacity:
        storage: 20Gi
    hostPath:
    path: "/mnt/data/wp"
    ```
5. anwenden:
    ```bash
    kubectl apply -k wordpress/.
