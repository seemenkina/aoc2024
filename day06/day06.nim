import sequtils
import sets
import tables

proc readInput(): (seq[seq[char]], (int, int), (int, int)) =
  let file = open("day06_input.txt")
  defer: file.close()
  var position: (int, int) = (0, 0)
  var direction: (int, int) = (0, 1)
  var lines: seq[seq[char]] = @[]
  for line in file.lines():
    let lineSeq = line.toSeq()
    lines.add(lineSeq)
    for i, c in lineSeq:
      if c == '^':
        position = (lines.len - 1, i)
        direction = (-1, 0)
      elif c == 'v':
        position = (lines.len - 1, i)
        direction = (1, 0)
      elif c == '>':
        position = (lines.len - 1, i)
        direction = (0, 1)
      elif c == '<':
        position = (lines.len - 1, i)
        direction = (0, -1)
  return (lines, position, direction)

proc turn(direction: (int, int)): (int, int) =
  if direction[0] == 0 and direction[1] == 1:
    return (1, 0)
  elif direction[0] == 0 and direction[1] == -1:
    return (-1, 0)
  elif direction[0] == 1 and direction[1] == 0:
    return (0, -1)
  else:
    return (0, 1)

proc get_set(): HashSet[(int, int)] =
  let (lines, position, direction) = readInput()
  var visited: HashSet[(int, int)] = initHashSet[(int, int)]()
  var next: (int, int) = (position[0] + direction[0], position[1] + direction[1])
  var nextDirection: (int, int) = direction
  visited.incl(next)
  while next[0] >= 0 and next[1] >= 0 and next[0] < lines.len and next[1] < lines[next[0]].len:
    if lines[next[0]][next[1]] == '#':
      next = (next[0] - nextDirection[0], next[1] - nextDirection[1])
      nextDirection = turn(nextDirection)
    else:
      visited.incl(next)
      nextDirection = nextDirection
      next = (next[0] + nextDirection[0], next[1] + nextDirection[1])
  visited.excl(next)
  return visited

proc check_loop(lines: seq[seq[char]], position: (int, int), direction: (int, int)): bool =
  var visited: Table[(int, int), seq[(int, int)]] = initTable[(int, int), seq[(int, int)]]()
  var next: (int, int) = (position[0] + direction[0], position[1] + direction[1])
  var nextDirection: (int, int) = direction
  visited[position] = @[(0, 0)]
  while next[0] >= 0 and next[1] >= 0 and next[0] < lines.len and next[1] < lines[next[0]].len:
    if lines[next[0]][next[1]] == '#':
      next = (next[0] - nextDirection[0], next[1] - nextDirection[1])
      nextDirection = turn(nextDirection)
    else:
      if next notin visited:
        visited[next] = @[]
      if visited[next].contains((nextDirection[0], nextDirection[1])):
        return true
      else:
        visited[next].add((nextDirection[0], nextDirection[1]))
      nextDirection = nextDirection
      next = (next[0] + nextDirection[0], next[1] + nextDirection[1])
  visited.del(next)
  return false

proc day6_a(): int = 
  let visited = get_set()
  return visited.len

proc day6_b(): int =
  let (lines, position, direction) = readInput()
  let visited = get_set()
  for key in visited:
    var lines_copy = lines
    lines_copy[key[0]][key[1]] = '#'
    if check_loop(lines_copy, position, direction):
      result += 1
  return result

echo day6_a() 
echo day6_b()