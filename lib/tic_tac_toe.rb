require 'pry'

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (input)
  input.to_i - 1
end

def move(board,index,token)
  board[index] = token
end

def position_taken?(board,index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

def turn(board)
  puts "PLease enter a number between 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    puts "Whoops! That's not a valid move"
    turn(board)
  end
end

def turn_count(board)
  board.count do |position|
    position != " "
  end
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  index = 0
  while index < WIN_COMBINATIONS.size
    sub_index = 0
    compaire_array =[]
    while sub_index < WIN_COMBINATIONS[index].size
      compaire_array << board[WIN_COMBINATIONS[index][sub_index]]
      sub_index +=1
    end
      if compaire_array.all?("O") || compaire_array.all?("X")
        return WIN_COMBINATIONS[index]
      end
    index += 1
  end
  return nil
end

def full?(board)
  board.all? do |position|
      position == "X" || position == "O"
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won?(board) && board[won?(board)[0]]
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
