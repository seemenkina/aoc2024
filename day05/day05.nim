import tables
import std/sets
import std/strutils
import std/sequtils
import std/algorithm

proc day5_a(): int =
  let file = open("day5_input.txt")
  defer: file.close()
  var table: Table[int, HashSet[int]] = initTable[int, HashSet[int]]()
  for line in file.lines:
    if line != "":
      let split_line = line.split("|")
      let left_int = parseInt(split_line[0])
      let right_int = parseInt(split_line[1])
      if left_int notin table:
        table[left_int] = initHashSet[int]()
      table[left_int].incl(right_int)
    else:
      break
  for line in file.lines:
    let split_line = line.split(",")
    let int_line = split_line.mapIt(parseInt(it))
    if int_line.isSorted(proc (a: int, b: int): int = 
      let seq_for_table = table.getOrDefault(a)
      if seq_for_table == initHashSet[int]() or b notin seq_for_table:
        return -1
      elif b in seq_for_table:
        return 0
      else:
        return 1
    , Descending):
      let middle_index = (int_line.len - 1) div 2
      result += int_line[middle_index]
  return result

proc day5_b(): int =
  let file = open("day5_input.txt")
  defer: file.close()
  var table: Table[int, HashSet[int]] = initTable[int, HashSet[int]]()
  for line in file.lines:
    if line != "":
      let split_line = line.split("|")
      let left_int = parseInt(split_line[0])
      let right_int = parseInt(split_line[1])
      if left_int notin table:
        table[left_int] = initHashSet[int]()
      table[left_int].incl(right_int)
    else:
      break

  for line in file.lines:
    let split_line = line.split(",")
    var int_line = split_line.mapIt(parseInt(it))
    let sorted_int_line = int_line.sorted(proc (a: int, b: int): int = 
      let seq_for_table = table.getOrDefault(a)
      if seq_for_table == initHashSet[int]() or b notin seq_for_table:
        return -1
      elif b in seq_for_table:
        return 0
      else:
        return 1
    , Descending)

    if sorted_int_line != int_line:
      let middle_index = (sorted_int_line.len - 1) div 2
      result += sorted_int_line[middle_index]
  return result

echo day5_a()
echo day5_b()