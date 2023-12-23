# card.rb
class Card
    attr_reader :mark, :rank, :value

    def initialize(mark, rank)
        @mark = mark
        @rank = rank
        @value = calculate_card_value(rank)
    end

    private

    def calculate_card_value(rank)
        return 10 if ['J', 'Q', 'K'].include?(rank)
        return 11 if rank == 'A'
        rank.to_i
    end
end