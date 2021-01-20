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

end