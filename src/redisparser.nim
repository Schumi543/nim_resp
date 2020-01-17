type
    ValueKind* = enum
        vkStr, vkError, vkInt, vkBulkStr, vkArray

    RedisValue* = ref object
        case kind*: ValueKind
        of vkStr: s*: string
        of vkError: err*: string
        of vkInt: i*: int
        of vkBulkStr: bs*: string
        of vkArray: l*: seq[RedisValue]

proc encodeValue*(v: RedisValue): string = ""

proc decodeString*(s: string): RedisValue = RedisValue(kind: vkInt, i: 1)
