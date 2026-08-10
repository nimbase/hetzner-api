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

suite "ssh_keys serialization":
  test "round-trips GetSshKeysResponse":
    let obj = hetzner.GetSshKeysResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetSshKeysResponse)) == openjson.toJson(obj)

  test "round-trips PostSshKeysResponse":
    let obj = hetzner.PostSshKeysResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PostSshKeysResponse)) == openjson.toJson(obj)

  test "round-trips GetSshKeysIdResponse":
    let obj = hetzner.GetSshKeysIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.GetSshKeysIdResponse)) == openjson.toJson(obj)

  test "round-trips PutSshKeysIdResponse":
    let obj = hetzner.PutSshKeysIdResponse()
    check openjson.toJson(openjson.fromJson(openjson.toJson(obj), hetzner.PutSshKeysIdResponse)) == openjson.toJson(obj)

suite "ssh_keys endpoints":
  test "GET /ssh_keys":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getSshKeys({}, "test", "test", "test")

  test "GET /ssh_keys/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.getSshKeysId(1)

  test "DELETE /ssh_keys/{id}":
    let client = initHetznerClient("test-key")
    client.baseUri = "http://127.0.0.1:" & $int(startMock())
    discard waitFor client.deleteSshKeysId("test")

