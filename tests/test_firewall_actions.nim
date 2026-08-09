# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T00:17:48+00:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "firewall_actions serialization":
  test "round-trips GetFirewallsIdActionsResponse":
    let obj = hetzner.GetFirewallsIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFirewallsIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostFirewallsIdActionsApplyToResourcesResponse":
    let obj = hetzner.PostFirewallsIdActionsApplyToResourcesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFirewallsIdActionsApplyToResourcesResponse)) == openjson.toJson(obj)

  test "round-trips PostFirewallsIdActionsRemoveFromResourcesResponse":
    let obj = hetzner.PostFirewallsIdActionsRemoveFromResourcesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFirewallsIdActionsRemoveFromResourcesResponse)) == openjson.toJson(obj)

  test "round-trips PostFirewallsIdActionsSetRulesResponse":
    let obj = hetzner.PostFirewallsIdActionsSetRulesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostFirewallsIdActionsSetRulesResponse)) == openjson.toJson(obj)

  test "round-trips GetFirewallsIdActionsActionIdResponse":
    let obj = hetzner.GetFirewallsIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetFirewallsIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "firewall_actions endpoints":
  test "GET /firewalls/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFirewallsIdActions(1, {}, {})

  test "GET /firewalls/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getFirewallsIdActionsActionId(1, 1)

