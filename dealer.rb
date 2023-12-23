# dealer.rb
class Dealer < Player
    def display_initial_hand
        puts "ディーラーの引いたカードは#{@hand[0].mark}の#{@hand[0].rank}です。"
        puts "ディーラーの引いた2枚目のカードは分かりません。"
    end

    def play_turn(deck)
        while calculate_hand_value < 17
            receive_card(deck.draw_card)
        end
    end
end