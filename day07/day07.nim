import sequtils
import sets
import tables

proc readInput(): int =
  let file = open("day07_simple.txt")
  defer: file.close()
  for line in file.lines():
    result += 1
  return result

proc day6_a(): int = 
  return readInput()

proc day6_b(): int =
  return readInput()

echo day6_a() 
echo day6_b()