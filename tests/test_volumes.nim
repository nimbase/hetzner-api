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

suite "volumes serialization":
  test "round-trips GetVolumesResponse":
    let obj = hetzner.GetVolumesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetVolumesResponse)) == openjson.toJson(obj)

  test "round-trips PostVolumesResponse":
    let obj = hetzner.PostVolumesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostVolumesResponse)) == openjson.toJson(obj)

  test "round-trips GetVolumesIdResponse":
    let obj = hetzner.GetVolumesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetVolumesIdResponse)) == openjson.toJson(obj)

  test "round-trips PutVolumesIdResponse":
    let obj = hetzner.PutVolumesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutVolumesIdResponse)) == openjson.toJson(obj)

suite "volumes endpoints":
  test "GET /volumes":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getVolumes({}, {}, "test", "test")

  test "GET /volumes/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getVolumesId(1)

  test "DELETE /volumes/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteVolumesId("test")

