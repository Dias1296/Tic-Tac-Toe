class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @wins = 0
    @losses = 0
    @games_played = 0
  end

  attr_accessor :name
  attr_accessor :symbol
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :games_played

end

class Game
  public

  def new_game #Start a new game
    @board_symbols = ('1'..'9').to_a #Clean board
    @board_checked = Array.new(9, false) #Array changed symbols
    get_player_profile(1)
    get_player_profile(2)
    while true 
      if @player_2.symbol == @player_1.symbol
        puts "Cannot use the same symbol as #{@player_1.name}"
      else
        break
      end
      puts "Choose another symbol"
      @player_2.symbol = gets.chomp
    end
    
    restart = 'N'
    while true
      play_turn(@player_1)
      if check_if_win(@player_1)
        restart = restart_game?(@player_1, @player_2)
        puts restart.upcase
        break
      end
      play_turn(@player_2)
      if check_if_win(@player_2)
        restart = restart_game?(@player_2, @player_1)
        puts restart.upcase
        break
      end
    end
    puts restart.upcase
    if restart.upcase == 'Y'
      restart_game
    end

  end

  private

  def restart_game
    @board_symbols = ('1'..'9').to_a #Clean board
    @board_checked = Array.new(9, false) #Array changed symbols
    restart = 'N'
    while true
      play_turn(@player_1)
      if check_if_win(@player_1)
        restart = restart_game?(@player_1, @player_2)
        if restart.upcase != 'Y'
          break
        else
          @board_symbols = ('1'..'9').to_a #Clean board
          @board_checked = Array.new(9, false) #Array changed symbols
          restart = 'N'
        end
      end
      play_turn(@player_2)
      if check_if_win(@player_2)
        restart = restart_game?(@player_2, @player_1)
        if restart.upcase != 'Y'
          break
        else
          @board_symbols = ('1'..'9').to_a #Clean board
          @board_checked = Array.new(9, false) #Array changed symbols
          restart = 'N'
        end
      end
    end
  end

  def restart_game?(winner, loser)
    winner.wins += 1
    winner.games_played += 1
    loser.losses += 1
    loser.games_played += 1
    puts "#{winner.name} HAS WON!!! { #{winner.name}: #{winner.wins} - #{loser.wins} :#{loser.name} }"
    puts "Would you like to play another game? [Y/N]"
    return gets.chomp
  end

  def play_turn(player) #Player turn
    puts "#{player.name} choose a place in the board to use your symbol!"
    draw_board
    
    while true
      play = gets.chomp
        case 
        when play.to_i>9
          puts "Invalid input! Please try again."
        when play.to_i<1
          puts "Invalid input! Please try again"
        else
          if @board_checked[play.to_i-1] == false
            update_board(player.symbol, play.to_i-1)
            break
          else
            puts "Invalid input! Please try again."
          end
        end
    end
  end

  def get_player_profile(player_number) #Method to get player parameters and initialize a new Player object
    puts "Player ##{player_number}! What is your name?!"
    name = gets.chomp
    while true
      puts "Choose a one character symbol to use in the game!"
      symbol = gets.chomp
      case symbol.length
      when 1
        break
      else
        i = false
        puts "Invalid input. Please choose another symbol!"
      end
    end
    instance_variable_set("@player_#{player_number}", Player.new(name, symbol)) #Create new Player object
    puts "Welcome to the game #{name}!"
  end

  def update_board(symbol, position)
    @board_symbols[position] = symbol
    @board_checked[position] = true
  end

  def draw_board
    puts "#{@board_symbols[0]} | #{@board_symbols[1]} | #{@board_symbols[2]}"
    puts "-*******-"
    puts "#{@board_symbols[3]} | #{@board_symbols[4]} | #{@board_symbols[5]}"
    puts "-*******-"
    puts "#{@board_symbols[6]} | #{@board_symbols[7]} | #{@board_symbols[8]}"
  end

  def check_if_win(player)
    player_symbols = @board_symbols.each_with_index.filter { |item, _| item == player.symbol }
    player_symbols_index = player_symbols.collect { |item| item[1]}
    puts player_symbols_index
    case
    when (player_symbols_index & [0,1,2]) == [0,1,2]
      return true
    when (player_symbols_index & [3,4,5]) == [3,4,5]
      return true
    when (player_symbols_index & [6,7,8]) == [6,7,8]
      return true
    when (player_symbols_index & [0,3,6]) == [0,3,6]
      return true
    when (player_symbols_index & [1,4,7]) == [1,4,7]
      return true
    when (player_symbols_index & [2,5,8]) == [2,5,8]
      return true
    when (player_symbols_index & [0,4,8]) == [0,4,8]
      return true
    when (player_symbols_index & [2,4,6]) == [2,4,6]
      return true
    else 
      return false
    end
  end

end

The_Game = Game.new()
The_Game.new_game