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
# def won?(board)
#   WIN_COMBINATIONS.detect do |win_combo|
#     position_1 = board[win_combo[0]]
#     position_2 = board[win_combo[1]]
#     position_3 = board[win_combo[2]]
#
#     position_1 == "X" && position_2 == "X" && position_3 == "X"
#     position_1 == "O" && position_2 == "O" && position_3 == "O"
#   end
#   return
# end

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



# def turn (board,player = current_player(board))
#   puts "Please enter 1-9:"
#   input = input_to_index(gets.strip)
#   if !valid_move?(board,input)
#     turn(board)
#   end
#   move(board,input,current_player(board))
#   display_board(board)
#   play(board)
# end
#
# def turn_count(board)
#   count = board.count {|field| field == "X" ||field == "O" }
# end
#
# def current_player (board)
#   if turn_count(board) % 2 == 0 || turn_count(board) == 0
#     return "X"
#   else
#     return "O"
#   end
# end
#
# def won?(board)
#   index = 0
#   while index < WIN_COMBINATIONS.size
#     sub_index = 0
#     compaire_array =[]
#     while sub_index < WIN_COMBINATIONS[index].size
#       compaire_array << board[WIN_COMBINATIONS[index][sub_index]]
#       sub_index +=1
#     end
#       if compaire_array.all?("O") || compaire_array.all?("X")
#         return WIN_COMBINATIONS[index]
#       end
#
#     index += 1
#   end
#   return nil
# end
#
# def full?(board)
#   (0..8).to_a.map { |i| position_taken?(board, i) }.all?
# end
#
# def draw?(board)
#   if full?(board) && !won?(board)
#     return true
#   end
# end
#
# def over?(board)
#   if won?(board) || draw?(board) ||full?(board)
#     return true
#   end
# end
#
# def winner(board)
#   winner = won?(board)
#     if winner == nil
#       return nil
#     else
#       a=board[winner.first]
#       return a
#     end
# end
#
# def play (board)
#   if turn_count(board) > 1
#     turn(board,current_player(board))
#   else
#       # current_player(board)
#       # turn(board,current_player(board))
#       if !over?(board) || !draw?(board)
#         if won?(board)
#           winner = winner(board)
#           puts "Congratulations #{winner}!"
#         end
#       end
#       turn_count(board)
#   end
# end
