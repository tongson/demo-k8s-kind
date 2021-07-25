__app_build()
{
  rm -f webserver
  CGO_ENABLED=0 go build \
    -trimpath -ldflags '-s -w' \
    -o webserver
}
