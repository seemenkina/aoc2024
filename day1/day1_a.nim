import std/strutils
import std/algorithm
import std/sequtils
import std/math

proc readFile(): (seq[int], seq[int]) =
  let file = open("day1_input.txt")
  defer: file.close()
  var result: (seq[int], seq[int]) = (@[], @[])
  for line in file.lines:
    let parts = line.splitWhitespace()
    result[0].add(parts[0].parseInt())
    result[1].add(parts[1].parseInt())
  return result

proc difference_sum(a: seq[int], b: seq[int]): int =
  let c = sorted(a, system.cmp[int])
  let d = sorted(b, system.cmp[int])
  return c.zip(d).map(proc (x: (int, int)): int = abs(x[0] - x[1])).sum()

let (a, b) = readFile()
# echo a
# echo b
echo difference_sum(a, b)
