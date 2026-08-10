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

suite "images serialization":
  test "round-trips GetImagesResponse":
    let obj = hetzner.GetImagesResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetImagesResponse)) == openjson.toJson(obj)

  test "round-trips GetImagesIdResponse":
    let obj = hetzner.GetImagesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetImagesIdResponse)) == openjson.toJson(obj)

  test "round-trips PutImagesIdResponse":
    let obj = hetzner.PutImagesIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutImagesIdResponse)) == openjson.toJson(obj)

suite "images endpoints":
  test "GET /images":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getImages({}, {}, {}, "test", true, "test", "test")

  test "GET /images/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getImagesId(1)

  test "DELETE /images/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteImagesId(1)

