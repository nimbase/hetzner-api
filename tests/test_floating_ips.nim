# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[asyncdispatch]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "floating_ips serialization":
  test "round-trips GetFloatingIpsResponse":
    let obj = hetzner.GetFloatingIpsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFloatingIpsResponse)) == openjson.toJson(obj)

  test "round-trips PostFloatingIpsResponse":
    let obj = hetzner.PostFloatingIpsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFloatingIpsResponse)) == openjson.toJson(obj)

  test "round-trips GetFloatingIpsIdResponse":
    let obj = hetzner.GetFloatingIpsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFloatingIpsIdResponse)) == openjson.toJson(obj)

  test "round-trips PutFloatingIpsIdResponse":
    let obj = hetzner.PutFloatingIpsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutFloatingIpsIdResponse)) == openjson.toJson(obj)

suite "floating_ips endpoints":
  test "GET /floating_ips":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFloatingIps("test", "test", {})

  test "GET /floating_ips/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFloatingIpsId(1)

  test "DELETE /floating_ips/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteFloatingIpsId(1)

