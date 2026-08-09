# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T04:08:19+00:00
# License: MIT
import std/[asyncdispatch, options, json]
import unittest
import pkg/openparser/json as openjson
import hetzner
import ./common

suite "placement_groups serialization":
  test "round-trips GetPlacementGroupsResponse":
    let obj = hetzner.GetPlacementGroupsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetPlacementGroupsResponse)) == openjson.toJson(obj)

  test "round-trips PostPlacementGroupsResponse":
    let obj = hetzner.PostPlacementGroupsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostPlacementGroupsResponse)) == openjson.toJson(obj)

  test "round-trips GetPlacementGroupsIdResponse":
    let obj = hetzner.GetPlacementGroupsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetPlacementGroupsIdResponse)) == openjson.toJson(obj)

  test "round-trips PutPlacementGroupsIdResponse":
    let obj = hetzner.PutPlacementGroupsIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutPlacementGroupsIdResponse)) == openjson.toJson(obj)

suite "placement_groups endpoints":
  test "GET /placement_groups":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getPlacementGroups({}, "test", "test", {})

  test "GET /placement_groups/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getPlacementGroupsId(1)

  test "DELETE /placement_groups/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deletePlacementGroupsId(1)

