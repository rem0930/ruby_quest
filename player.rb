# player.rb
class Player
    attr_reader :hand

    def initialize
        @hand = []
    end

    def receive_card(card)
        @hand << card
    end

    def calculate_hand_value
        values = @hand.map(&:value)
        sum = values.sum
        num_aces = values.count { |value| value == 11 }

        while sum > 21 && num_aces.positive?
            sum -= 10
            num_aces -= 1
        end

        sum
    end
end  