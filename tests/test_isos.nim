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

suite "isos serialization":
  test "round-trips GetIsosResponse":
    let obj = hetzner.GetIsosResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetIsosResponse)) == openjson.toJson(obj)

  test "round-trips GetIsosIdResponse":
    let obj = hetzner.GetIsosIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetIsosIdResponse)) == openjson.toJson(obj)

suite "isos endpoints":
  test "GET /isos":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getIsos("test")

  test "GET /isos/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getIsosId(1)

