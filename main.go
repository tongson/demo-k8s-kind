package main

import (
	"embed"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/tongson/demo-kubernetes-kind/external/glecho"
	"github.com/tongson/LadyLua"
	"github.com/yuin/gopher-lua"
)

//go:embed main/*
var mainSrc embed.FS

type (
	Host struct {
		Echo *echo.Echo
	}
)

var hosts = map[string]*Host{}

func checkHost(c echo.Context) error {
	req := c.Request()
	res := c.Response()
	host := hosts[req.Host]
	if host == nil {
		return echo.ErrNotFound
	} else {
		host.Echo.ServeHTTP(res, req)
		return nil
	}
}

func handle(c echo.Context) error {
	L := lua.NewState()
	defer L.Close()
	glecho.Load(L, c)
	ll.Preload(L)
	ll.PreloadGo(L, "json")
	return ll.Main(L, ll.ReadFile(mainSrc, "main/main.lua"))
}

func main() {
	h := echo.New()
	h.Use(middleware.Logger())
	h.Use(middleware.Recover())
	hosts["local.example.com"] = &Host{h}
	h.GET("/endpoint", handle)

	e := echo.New()
	e.Any("/*", checkHost)
	e.Logger.Fatal(e.Start(":1323"))
}
