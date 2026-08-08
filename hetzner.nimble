# Package

version       = "3.0.0"
author        = "George Lemon"
description   = "This is the official API documentation for the Public Hetzner Cloud."
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 2.0.0"
requires "openparser"

task test, "Run all tests":
  import std/os
  for testFile in walkFiles("tests/test_*.nim"):
    exec "nim r " & testFile
