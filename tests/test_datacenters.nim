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

suite "datacenters serialization":
  test "round-trips GetDatacentersResponse":
    let obj = hetzner.GetDatacentersResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetDatacentersResponse)) == openjson.toJson(obj)

  test "round-trips GetDatacentersIdResponse":
    let obj = hetzner.GetDatacentersIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetDatacentersIdResponse)) == openjson.toJson(obj)

suite "datacenters endpoints":
  test "GET /datacenters":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getDatacenters("test")

  test "GET /datacenters/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getDatacentersId(1)

