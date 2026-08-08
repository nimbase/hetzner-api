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

suite "firewalls serialization":
  test "round-trips GetFirewallsResponse":
    let obj = hetzner.GetFirewallsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFirewallsResponse)) == openjson.toJson(obj)

  test "round-trips PostFirewallsResponse":
    let obj = hetzner.PostFirewallsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFirewallsResponse)) == openjson.toJson(obj)

  test "round-trips GetFirewallsIdResponse":
    let obj = hetzner.GetFirewallsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFirewallsIdResponse)) == openjson.toJson(obj)

  test "round-trips PutFirewallsIdResponse":
    let obj = hetzner.PutFirewallsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutFirewallsIdResponse)) == openjson.toJson(obj)

suite "firewalls endpoints":
  test "GET /firewalls":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFirewalls({}, "test", "test")

  test "GET /firewalls/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFirewallsId(1)

  test "DELETE /firewalls/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteFirewallsId(1)

