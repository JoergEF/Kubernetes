# Kubernetes-Dashboard

1. Dashboard veröffentlichen:
    ```bash
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
    kubectl apply -f kubernetes-dashboard/kubernetes-dashboard-service-np.yaml
    kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
    ```
2. mit Secret am Dashboard anmelden (optional):

    https://192.168.100.11:30002
    