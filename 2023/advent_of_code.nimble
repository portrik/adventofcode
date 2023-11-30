# Package

version       = "0.1.0"
author        = "Patrik Dvořáček"
description   = "Advent of Code 2023 Solutions in Nim"
license       = "GPL-3.0-or-later"
srcDir        = "src"
bin           = @["advent_of_code"]


# Dependencies

requires "nim >= 2.0.0"

task test, "Run all tests":
  exec "testament pattern \"tests/*.nim\""
