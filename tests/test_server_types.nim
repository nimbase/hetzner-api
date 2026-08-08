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

suite "server_types serialization":
  test "round-trips GetServerTypesResponse":
    let obj = hetzner.GetServerTypesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServerTypesResponse)) == openjson.toJson(obj)

  test "round-trips GetServerTypesIdResponse":
    let obj = hetzner.GetServerTypesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetServerTypesIdResponse)) == openjson.toJson(obj)

suite "server_types endpoints":
  test "GET /server_types":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServerTypes("test")

  test "GET /server_types/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getServerTypesId(1)

