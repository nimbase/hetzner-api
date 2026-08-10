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

suite "image_actions serialization":
  test "round-trips GetImagesIdActionsResponse":
    let obj = hetzner.GetImagesIdActionsResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetImagesIdActionsResponse)) == openjson.toJson(obj)

  test "round-trips PostImagesIdActionsChangeProtectionResponse":
    let obj = hetzner.PostImagesIdActionsChangeProtectionResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostImagesIdActionsChangeProtectionResponse)) == openjson.toJson(obj)

  test "round-trips GetImagesIdActionsActionIdResponse":
    let obj = hetzner.GetImagesIdActionsActionIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetImagesIdActionsActionIdResponse)) == openjson.toJson(obj)

suite "image_actions endpoints":
  test "GET /images/{id}/actions":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getImagesIdActions(1, {}, {})

  test "GET /images/{id}/actions/{action_id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getImagesIdActionsActionId(1, 1)

