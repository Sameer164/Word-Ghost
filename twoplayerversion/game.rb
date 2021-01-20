require 'set'
require_relative './player.rb'
require 'byebug'

FILE = File.open('text.txt')
FILEDATA= FILE.readlines.map(&:chomp)
SET = FILEDATA.to_set

class Game

    attr_reader :dictionary, :current_player, :previous_player
    def initialize(name_player1, name_player2)
        @fragment = ""
        player1 = Player.new(name_player1)
        player2 = Player.new(name_player2)
        @players = [player1, player2]
        @dictionary = SET
        @current_player = @players[0]
        @previous_player = @players[-1]
        @hash = {}
        @players.each do |player|
            @hash[player.name] = ""
        end
    end

    def next_player!
        @players.rotate!
        @current_player = @players[0]
        @previous_player = @players[-1]
        
    end

    def valid_play?(str)
        alphabets = 'abcdefghijklmnopqrstuvwxyz'
        if !alphabets.include?(str)
            return false
        end

        curr_word = @fragment
        curr_word += str
        @dictionary.each do |word|
            if word.start_with?(curr_word)
                return true
            end

        end

        return false
    end
    
    def next_letter(name)
        letters = 'GHOST'
        last = @hash[name]
        if last.length == 0
            return 'G'
        else
            return letters[letters.index(last[-1]) + 1]
        end
    end
    
    def take_turn(p)
        
        if @fragment.length == 0
            puts "Start The Word #{p.name}"
            puts
        else
            puts "The word is #{@fragment}. Guess #{p.name} Guess"
            puts
        end

        input_letter = p.guess
        while !valid_play?(input_letter)
            p.alert_invalid_guess
            input_letter = p.guess
        end

        @fragment += input_letter
        puts "The word is #{@fragment}"
        puts

        if @dictionary.member?(@fragment)
            @hash[p.name] += next_letter(p.name)
            puts "#{@previous_player.name} has won this round."
            puts
            puts "#{p.name}: #{@hash[p.name]}                       #{@previous_player.name}: #{@hash[@previous_player.name]}"
            puts
            puts "Let's begin again"
            puts
            @fragment = ""
        end


        return false
    end

    def has_lost?(p)
        return @hash[p.name] == "GHOST"
        
    end


    def play_game
        while true
           take_turn(@current_player)
           next_player!
           if has_lost?(@previous_player)
                puts "#{@current_player.name} has won"
                puts
                break
           end
           
        end
    end


end
 
g = Game.new('sameer', 'samikshya')
g.play_game




