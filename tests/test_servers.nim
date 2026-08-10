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

suite "servers serialization":
  test "round-trips GetServersResponse":
    let obj = hetzner.GetServersResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServersResponse)) == openjson.toJson(obj)

  test "round-trips PostServersResponse":
    let obj = hetzner.PostServersResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostServersResponse)) == openjson.toJson(obj)

  test "round-trips GetServersIdResponse":
    let obj = hetzner.GetServersIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServersIdResponse)) == openjson.toJson(obj)

  test "round-trips PutServersIdResponse":
    let obj = hetzner.PutServersIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutServersIdResponse)) == openjson.toJson(obj)

  test "round-trips DeleteServersIdResponse":
    let obj = hetzner.DeleteServersIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.DeleteServersIdResponse)) == openjson.toJson(obj)

  test "round-trips GetServersIdMetricsResponse":
    let obj = hetzner.GetServersIdMetricsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServersIdMetricsResponse)) == openjson.toJson(obj)

suite "servers endpoints":
  test "GET /servers":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServers("test", "test", {}, {})

  test "GET /servers/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServersId(1)

  test "DELETE /servers/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteServersId(1)

  test "GET /servers/{id}/metrics":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServersIdMetrics(1, {}, "test", "test", "test")

