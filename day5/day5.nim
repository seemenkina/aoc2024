import tables
import std/sets
import std/strutils
import std/sequtils

proc check_line(table: Table[int, HashSet[int]], seq_line: seq[int]): bool =
  var if_ok = true
  for i in 0..seq_line.len-1:
    let seq_after_i = seq_line[i+1..^1]
    let seq_before_i = seq_line[0..i-1]
    let seq_after_i_set = seq_after_i.toHashSet()
    let seq_before_i_set = seq_before_i.toHashSet()

    let seq_for_table = table.getOrDefault(seq_line[i])
    if seq_for_table == initHashSet[int]() and seq_after_i_set.len == 0:
        if_ok = true
    else: 
        let intersection_before = seq_before_i_set * seq_for_table
        if (seq_after_i_set <= seq_for_table) and (intersection_before.len == 0):
            if_ok = true
        else:
            if_ok = false
            break
  return if_ok


proc fix_line(table: Table[int, HashSet[int]], seq_line: seq[int]): seq[int] =
  var seq_line_copy = seq_line
  for i in 0..seq_line.len-1:
    let current_num = seq_line_copy[i]
    var i_copy = i
    let seq_for_table = table.getOrDefault(current_num)
    for j in i+1..seq_line.len-1:
      let next_num = seq_line_copy[j]
      if seq_for_table == initHashSet[int]() or next_num notin seq_for_table:
        seq_line_copy[i_copy] = next_num
        seq_line_copy[j] = current_num
        i_copy = j
      else:
        continue
  return seq_line_copy

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
    if check_line(table, int_line):
      let middle_index: int = (int_line.len - 1) div 2
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
    let int_line = split_line.mapIt(parseInt(it))
    if not check_line(table, int_line):
      var seq_line_copy = fix_line(table, int_line)
      while not check_line(table, seq_line_copy):
        seq_line_copy = fix_line(table, seq_line_copy)
      let middle_index = (seq_line_copy.len - 1) div 2
      result += seq_line_copy[middle_index]
  return result

echo day5_a()
echo day5_b()