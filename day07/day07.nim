import sequtils
import strutils
import algorithm

proc calculate_day7_a(numbers: seq[int], operations: seq[char], sum: int): int =
  result = numbers[0]
  for i in 0..operations.len - 1:
    if operations[i] == '+':
      result += numbers[i + 1]
    else:
      result *= numbers[i + 1]
    if result > sum:
      return 0
  return result

proc permutations_day7_a(numbers: seq[int], sum: int): int =
  result = 0
  let count = numbers.len - 1
  for i in 0..count:
    var chars = "*".repeat(count - i) & "+".repeat(i)
    if chars.len == 1:
      if calculate_day7_a(numbers, chars.toSeq(), sum) == sum:
        return sum
    else:
      chars.sort()
      if calculate_day7_a(numbers, chars.toSeq(), sum) == sum:
        return sum
      while chars.nextPermutation():
        if calculate_day7_a(numbers, chars.toSeq(), sum) == sum:
          return sum
  return 0

proc calculate_day7_b(numbers: seq[int], operations: seq[char], sum: int): int =
  result = numbers[0]
  for i in 0..operations.len - 1:
    if operations[i] == '+':
      result += numbers[i + 1]
    elif operations[i] == '*':
      result *= numbers[i + 1]
    else:
      let res_str = result.intToStr()
      let num_str = numbers[i + 1].intToStr()
      result = parseInt(res_str & num_str)
    if result > sum:
      return 0
  return result

proc permutations_day7_b(numbers: seq[int], sum: int): int =
  result = 0
  let count = numbers.len - 1
  for i in 0..count:
    for j in 0..count-i:
      var chars = "*".repeat(count - j - i) & "+".repeat(i) & "|".repeat(j)
      if chars.len == 1:
        if calculate_day7_b(numbers, chars.toSeq(), sum) == sum:
          return sum
      else:
        chars.sort()
        if calculate_day7_b(numbers, chars.toSeq(), sum) == sum:
          return sum
        while chars.nextPermutation():
          if calculate_day7_b(numbers, chars.toSeq(), sum) == sum:
            return sum
  return 0

proc day7_a(): int = 
  let file = open("day07_input.txt")
  defer: file.close() 
  for line in file.lines():
    let parts = line.split(": ")
    let res = parseInt(parts[0])
    let numbers = parts[1].splitWhitespace().mapIt(parseInt(it))
    result += permutations_day7_a(numbers, res)
  return result

proc day7_b(): int =
  let file = open("day07_input.txt")
  defer: file.close() 
  for line in file.lines():
    let parts = line.split(": ")
    let res = parseInt(parts[0])
    let numbers = parts[1].splitWhitespace().mapIt(parseInt(it))
    result += permutations_day7_b(numbers, res)
  return result

echo day7_a() 
echo day7_b()
