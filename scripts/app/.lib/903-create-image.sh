__app_image()
{
  rm -f webserver.oci
  local img
  img=$(buildah from scratch)
  buildah copy "${img}" webserver /webserver
  buildah config --entrypoint '["/webserver"]' "${img}"
  buildah config --cmd '' "${img}"
  buildah commit --rm --squash --format oci "${img}" "oci-archive:${PWD}/webserver.oci:example.com/webserver:latest"
}
