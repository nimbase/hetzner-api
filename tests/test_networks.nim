# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:31:24+03:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "networks serialization":
  test "round-trips GetNetworksResponse":
    let obj = hetzner.GetNetworksResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetNetworksResponse)) == openjson.toJson(obj)

  test "round-trips PostNetworksResponse":
    let obj = hetzner.PostNetworksResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostNetworksResponse)) == openjson.toJson(obj)

  test "round-trips GetNetworksIdResponse":
    let obj = hetzner.GetNetworksIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetNetworksIdResponse)) == openjson.toJson(obj)

  test "round-trips PutNetworksIdResponse":
    let obj = hetzner.PutNetworksIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutNetworksIdResponse)) == openjson.toJson(obj)

suite "networks endpoints":
  test "GET /networks":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getNetworks("test", "test")

  test "GET /networks/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getNetworksId(1)

  test "DELETE /networks/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteNetworksId(1)

