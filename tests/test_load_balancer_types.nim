# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-10T04:22:05+00:00
# License: MIT
import std/[asyncdispatch]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "load_balancer_types serialization":
  test "round-trips GetLoadBalancerTypesResponse":
    let obj = hetzner.GetLoadBalancerTypesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancerTypesResponse)) == openjson.toJson(obj)

  test "round-trips GetLoadBalancerTypesIdResponse":
    let obj = hetzner.GetLoadBalancerTypesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetLoadBalancerTypesIdResponse)) == openjson.toJson(obj)

suite "load_balancer_types endpoints":
  test "GET /load_balancer_types":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancerTypes("test")

  test "GET /load_balancer_types/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getLoadBalancerTypesId(1)

