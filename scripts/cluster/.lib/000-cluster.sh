__cluster_create()
{
  kind create cluster --config=../configs/kind.yaml
}

__cluster_add_ingress()
{
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
  until kubectl wait --namespace ingress-nginx \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/component=controller \
    --timeout=1800s
  do
    sleep 1
  done
}

