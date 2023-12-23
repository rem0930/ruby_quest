# deck.rb
require_relative 'card'
class Deck
    attr_reader :cards

    def initialize
        @cards = generate_deck
    end

    def draw_card
        @cards.pop
    end

    private

    def generate_deck
        marks = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
        ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
        cards = []

        marks.each do |mark|
            ranks.each do |rank|
                cards << ::Card.new(mark, rank)
            end
        end
    
        cards.shuffle
    end
end  