import sequtils
import tables

proc read_matrix(): seq[seq[char]] =
  let file = open("day4_input.txt")
  defer: file.close()
  for line in file.lines:
    result.add(line.toSeq())
  return result

proc check_around(matrix: seq[seq[char]], row: int, col: int, letter: char, directions: seq[(int, int)]): Table[(int, int), (int, int)] =
  for (dr, dc) in directions:
    let r = row + dr
    let c = col + dc
    if r >= 0 and r < matrix.len and c >= 0 and c < matrix[0].len:
      if matrix[r][c] == letter:
        result[(r, c)] = (dr, dc)
  return result

proc day4_a(): int =
  let matrix = read_matrix()
  let directions = @[(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]
  for i in 0..matrix.len - 1:
    for j in 0..matrix[0].len - 1:
      if matrix[i][j] == 'X':
        let around = check_around(matrix, i, j, 'M', directions)
        if around.len < 1:
          continue
        else:
          for key in around.keys:
            let (r, c) = key
            let (dr, dc) = around[(r, c)]
            let around2 = check_around(matrix, r, c, 'A', @[(dr, dc)])
            if around2.len < 1:
              continue
            else:
              for key2 in around2.keys:
                let (r2, c2) = key2
                let (dr2, dc2) = around2[(r2, c2)]
                let around3 = check_around(matrix, r2, c2, 'S', @[(dr2, dc2)])
                if around3.len < 1:
                  continue
                else:
                  result += 1
      else:
        continue
  
  return result 


proc check_x_mas(matrix: seq[seq[char]], row: int, col: int): int =
  let first_group = @['M', 'M', 'S', 'S']
  let second_group = @['S', 'M', 'M', 'S']
  let third_group = @['S', 'S', 'M', 'M']
  let fourth_group = @['M', 'S', 'S', 'M']

  var current_group: seq[char] = @[]
  if row - 1 >= 0 and col - 1 >= 0 and row + 1 < matrix.len and col + 1 < matrix[0].len:
    current_group = @[matrix[row - 1][col - 1], matrix[row - 1 ][col + 1], matrix[row + 1][col + 1], matrix[row + 1][col - 1]]
  else:
    return 0

  if current_group == first_group:
    result += 1
  elif current_group == second_group:
    result += 1
  elif current_group == third_group:
    result += 1
  elif current_group == fourth_group:
    result += 1
  else:
    result += 0
  return result


proc day4_b(): int =
  let matrix = read_matrix()
  for i in 0..matrix.len - 1:
    for j in 0..matrix[0].len - 1:
      if matrix[i][j] == 'A':
        result += check_x_mas(matrix, i, j)
      else:
        continue
  return result

echo day4_a()
echo day4_b()
