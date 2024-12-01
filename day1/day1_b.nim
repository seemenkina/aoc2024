import std/strutils
import std/algorithm
import std/tables

proc readFile(): (seq[int], seq[int]) =
  let file = open("day1_input.txt")
  defer: file.close()
  var result: (seq[int], seq[int]) = (@[], @[])
  for line in file.lines:
    let parts = line.splitWhitespace()
    result[0].add(parts[0].parseInt())
    result[1].add(parts[1].parseInt())
  result[0].sort()
  result[1].sort()
  return result

let (a, b) = readFile()
# echo a
# echo b

let d = b.toCountTable()
# echo d

var result: int = 0
for key in a:
  result += d[key] * key

echo result
