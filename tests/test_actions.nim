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

suite "actions serialization":
  test "round-trips GetActionsResponse":
    let obj = hetzner.GetActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetActionsResponse)) == openjson.toJson(obj)

  test "round-trips GetActionsIdResponse":
    let obj = hetzner.GetActionsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetActionsIdResponse)) == openjson.toJson(obj)

suite "actions endpoints":
  test "GET /actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getActions(1, {}, {})

  test "GET /actions/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getActionsId(1)

