# blackjack_game.rb
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class BlackjackGame
    def initialize
        @deck = Deck.new
        @player = Player.new
        @dealer = Dealer.new
    end

    def start
        puts 'ブラックジャックを開始します。'
        deal_initial_cards
        @dealer.display_initial_hand
        player_turn
        dealer_turn
        determine_winner
        puts 'ブラックジャックを終了します。'
    end

    private

    def deal_initial_cards
        2.times do
            @player.receive_card(@deck.draw_card)
            @dealer.receive_card(@deck.draw_card)
        end
    end

    def player_turn
        while true
            display_player_hand
            puts 'カードを引きますか？(Y/N)'
        choice = gets.chomp.upcase

        if choice == 'Y'
            @player.receive_card(@deck.draw_card)
        else
            break
        end

        if @player.calculate_hand_value > 21
            puts 'あなたの得点が21を超えました。あなたの負けです。'
            exit
        end
    end
end

    def dealer_turn
        @dealer.play_turn(@deck)
        puts "ディーラーの引いた2枚目のカードは#{@dealer.hand[1].mark}の#{@dealer.hand[1].rank}でした。"
    end

    def display_player_hand
        score = @player.calculate_hand_value
        puts "あなたの現在の得点は#{score}です。"
    end

    def determine_winner
        display_player_hand
        display_dealer_hand

        player_score = @player.calculate_hand_value
        dealer_score = @dealer.calculate_hand_value

        if player_score > 21
            puts 'あなたの得点が21を超えました。あなたの負けです。'
        elsif dealer_score > 21 || player_score > dealer_score
            puts 'あなたの勝ちです！'
        elsif player_score < dealer_score
            puts 'ディーラーの勝ちです！'
        else
            puts '引き分けです。'
        end
    end

    def display_dealer_hand
        score = @dealer.calculate_hand_value
        puts "ディーラーの現在の得点は#{score}です。"
    end
end

# ゲームの開始
game = BlackjackGame.new
game.start