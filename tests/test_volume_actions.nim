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

suite "volume_actions serialization":
  test "round-trips GetVolumesIdActionsResponse":
    let obj = hetzner.GetVolumesIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetVolumesIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostVolumesIdActionsAttachResponse":
    let obj = hetzner.PostVolumesIdActionsAttachResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostVolumesIdActionsAttachResponse)) == openjson.toJson(obj)

  test "round-trips PostVolumesIdActionsChangeProtectionResponse":
    let obj = hetzner.PostVolumesIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostVolumesIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips PostVolumesIdActionsDetachResponse":
    let obj = hetzner.PostVolumesIdActionsDetachResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostVolumesIdActionsDetachResponse)) == openjson.toJson(obj)

  test "round-trips PostVolumesIdActionsResizeResponse":
    let obj = hetzner.PostVolumesIdActionsResizeResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostVolumesIdActionsResizeResponse)) == openjson.toJson(obj)

  test "round-trips GetVolumesIdActionsActionIdResponse":
    let obj = hetzner.GetVolumesIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetVolumesIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "volume_actions endpoints":
  test "GET /volumes/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getVolumesIdActions(1, {}, {})

  test "POST /volumes/{id}/actions/detach":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.postVolumesIdActionsDetach(1)

  test "GET /volumes/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getVolumesIdActionsActionId(1, 1)

