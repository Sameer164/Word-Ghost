class Player

    attr_reader :name
    def initialize(name)
        @name = name
    end

    def guess
        input = gets.chomp
        return input
    end

    def alert_invalid_guess
        puts "Sorry #{@name}. We can't add that"
        return true
    end

    def automate(available_words, current_word)
        alphabets = "abcdefghijklmnopqrstuvwxyz"
        alphabets.each_char do |char|
            if !(available_words.include?(current_word + char)) && available_words.any? {|word| word.start_with?(current_word + char)}
                return char
            end
        end
        
    end


end