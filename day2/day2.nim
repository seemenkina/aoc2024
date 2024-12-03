import std/strutils
import std/algorithm
import std/sequtils

proc check_sequence(parts: seq[int]): bool =
    var is_ok: bool = true
    if ( parts.isSorted()) or ( parts.isSorted(Descending)):
      for i in 0..parts.len() - 2:
        let filtered = abs(parts[i] - parts[i+1]) <= 3 and abs(parts[i] - parts[i+1]) != 0
        if not filtered:
          is_ok = false
          break
    else:
      is_ok = false
    return is_ok

proc day2_a(): int =
  let file = open("day2_input.txt")
  defer: file.close()
  for line in file.lines:
    let parts = line.splitWhitespace().mapIt(it.parseInt())
    if check_sequence(parts):
      result += 1
  return result

proc day2_b(): int =
  let file = open("day2_input.txt")
  defer: file.close()
  for line in file.lines:
    let parts = line.splitWhitespace().mapIt(it.parseInt())
    for i in 0..parts.len() - 1:
      var partial_seq = parts
      partial_seq.delete(i)
      if check_sequence(partial_seq):
        result += 1
        break
  return result

echo day2_a()
echo day2_b()
