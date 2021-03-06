

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
counter = 0
board.each do |space|
  if space == 'X' || space == "O"
    counter += 1
  end 
end
return counter
end


def current_player(board)
  turn_count(board).even? ? "X" : "O"
end



def won?(board)

  WIN_COMBINATIONS.each do |arr|

    one = arr[0]
    two = arr[1]
    three = arr[2]

    if board[one] == board[two] && board[two] == board[three] && board[one] != " "
        return arr
    end
  end
  return false
end


def full?(board)

  not_full = board.any? do |space|
    space == " " || space == "  "
  end
  !not_full
end


def draw?(board)
 !won?(board) && full?(board) ? true : false
end

def over?(board)
  if won?(board) != false || draw?(board) || full?(board)
    return true
  else 
    return false
  end
end

def winner(board)
  if won?(board) != false
    arr = won?(board)
  return board[arr[0]]
end
end


def play(board)

  while !over?(board)
    turn(board)
  end

if draw?(board)
  puts "Cats Game!"
else
  puts "Congratulations #{winner(board)}!"
end

end
