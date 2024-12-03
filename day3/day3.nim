import std/re
import std/strutils

proc parse_line(line: string): int =
  let re = re"mul\(([0-9]+),([0-9]+)\)"
  let re_number = re"([0-9]+)"
  for m in line.findAll(re):
    let numbers = m.findAll(re_number)
    result += parseInt(numbers[0]) * parseInt(numbers[1])
  return result

proc day3_a(): int =
  let file = open("day3_simple.txt")
  defer: file.close()
  for line in file.lines:
    result += parse_line(line)
  return result


proc day3_b(): int =
  let file = open("day3_input.txt")
  defer: file.close()
  let re_do = re"do\(\)"
  let re_don = re"don\'t\(\)"
  var line_copy: string = "do()"
  for line in file.lines:
    line_copy = line_copy & line

  while line_copy.find(re_do) != -1:
    let do_tuple = line_copy.findBounds(re_do)

    var don_tuple = line_copy.findBounds(re_don, do_tuple[0])
    if don_tuple[0] == -1:
      don_tuple = (line_copy.len - 1, line_copy.len - 1)

    var temp_line: string = line_copy[do_tuple[0]..don_tuple[1]]
    result += parse_line(temp_line)
    line_copy = line_copy[don_tuple[1]+1..^1]
  return result

echo day3_a()
echo day3_b()
