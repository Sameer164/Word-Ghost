require 'set'
require_relative './player.rb'
require 'byebug'

FILE = File.open('text.txt')
FILEDATA= FILE.readlines.map(&:chomp)
SET = FILEDATA.to_set

class Game

    attr_reader :dictionary, :current_player, :previous_player
    def initialize(*args)
        @fragment = ""
        @players = []
        args.each do |name|
            @players << Player.new(name)
        end
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
            puts "=============Start The Word #{p.name}=============="
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
            puts "================#{p.name} has lost this round.==============="
            puts
            
            
            @players.each do |p1|
                puts "#{p1.name}: #{@hash[p1.name]}"
            end
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
        while @players.length >= 1
           if @players.length == 1
               puts "====================#{@players[0].name} has won!==============="
               break
           end
           take_turn(@current_player)
           next_player!
           if has_lost?(@previous_player)
                puts "===================#{@players.pop.name} has been removed.==========="
                
           end
           
        end
    end


end

g = Game.new('sameer', 'samikshya', 'niranjan')
g.play_game




