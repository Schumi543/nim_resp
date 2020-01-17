# Package

version       = "0.1.0"
author        = "Schumi543"
description   = "RESP (REdis Serialization Protocol) in Nim."
license       = "MIT"
srcDir        = "src"
bin           = @["nim_resp"]

backend       = "cpp"

# Dependencies

requires "nim >= 1.0.4"
