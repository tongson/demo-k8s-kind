__cluster_ps()
{
  podman exec -it kind-control-plane crictl ps
}
