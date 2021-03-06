import redisparser, tables, strformat


var testpairs = initOrderedTable[RedisValue, string]()
testpairs[RedisValue(kind:vkStr, s:"Hello, World")] = "+Hello, World\r\n"
testpairs[RedisValue(kind:vkInt, i:341)] = ":341\r\n"
testpairs[RedisValue(kind:vkError, err:"Not found")] = "-Not found\r\n"
testpairs[RedisValue(kind:vkArray, l: @[RedisValue(kind:vkStr, s:"Hello World"), RedisValue(kind:vkInt, i:23)])] = "*2\r\n+Hello World\r\n:23\r\n\r\n"
testpairs[RedisValue(kind:vkBulkStr, bs:"Hello, World THIS IS REALLY NICE")] = "$32\r\nHello, World THIS IS REALLY NICE\r\n"


# echo $encodeValue(RedisValue(kind:vkStr, s:"Hello, World"))
# # # +Hello, World
# echo $encodeValue(RedisValue(kind:vkInt, i:341))
# # # :341
# echo $encodeValue(RedisValue(kind:vkError, err:"Not found"))
# # # -Not found
# echo $encodeValue(RedisValue(kind:vkArray, l: @[RedisValue(kind:vkStr, s:"Hello World"), RedisValue(kind:vkInt, i:23)]  ))
# # #*2
# # #+Hello World
# # #:23

# echo $encodeValue(RedisValue(kind:vkBulkStr, bs:"Hello, World THIS IS REALLY NICE"))
# # #$32
# # # Hello, World THIS IS REALLY NICE  

# MORE TESTS 
# echo decodeString("*3\r\n:1\r\n:2\r\n:3\r\n\r\n")
# # # @[1, 2, 3]
# echo decodeString("+Hello, World\r\n")
# # # Hello, World
# echo decodeString("-Not found\r\n")
# # # Not found
# echo decodeString(":1512\r\n")
# # # 1512
# echo $decodeString("$32\r\nHello, World THIS IS REALLY NICE\r\n")
# # Hello, World THIS IS REALLY NICE
# echo decodeString("*2\r\n+Hello World\r\n:23\r\n")
# # @[Hello World, 23]
# echo decodeString("*2\r\n*3\r\n:1\r\n:2\r\n:3\r\n\r\n*5\r\n:5\r\n:7\r\n+Hello Word\r\n-Err\r\n$6\r\nfoobar\r\n")
# # @[@[1, 2, 3], @[5, 7, Hello Word, Err, foobar]]
# echo $decodeString("*4\r\n:51231\r\n$3\r\nfoo\r\n$-1\r\n$3\r\nbar\r\n")
# # @[51231, foo, , bar]
for k, v in testpairs.pairs():
    doAssert encodeValue(k) == v
    doAssert decodeString(v) == k
