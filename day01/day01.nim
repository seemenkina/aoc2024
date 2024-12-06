import std/strutils
import std/algorithm
import std/sequtils
import std/math
import std/tables

proc readFile(): (seq[int], seq[int]) =
  let file = open("day1_input.txt")
  defer: file.close()
  for line in file.lines:
    let parts = line.splitWhitespace()
    result[0].add(parts[0].parseInt())
    result[1].add(parts[1].parseInt())
  result[0].sort()
  result[1].sort()
  return result

proc day1_a(a: seq[int], b: seq[int]): int =
  return a.zip(b).map(proc (x: (int, int)): int = abs(x[0] - x[1])).sum()

proc day1_b(a: seq[int], b: seq[int]): int =
  let d = b.toCountTable()
  for key in a:
    result += d[key] * key
  return result

let (a, b) = readFile()
echo day1_a(a, b)
echo day1_b(a, b)


