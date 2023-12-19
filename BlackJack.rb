# クラスの定義
class BlackjackGame
    # カードのマークとランクを定義
    MARKS = ['ハート', 'ダイヤ', 'クラブ', 'スペード']
    RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

    def initialize
        # プレイヤーとディーラーの手札を初期化
        @player_hand = []
        @dealer_hand = []
    end

    def start
        #　ゲームを開始するメソッド
        puts 'ブラックジャックを開始します。'
        deal_initial_cards #プレイヤーとディーラーに最初の2枚のカードを配る
        display_player_and_dealer_hands #初期手札を表示
        player_turn # プレイヤーのターン実行
        dealer_turn # ディーラーのターンを実行
        determin_winner #　勝者を決定して結果を表示
        puts 'ブラックジャックを終了します。'
    end

    private

    # プレイヤーとディーラーに最初の二枚のカードを配るメソッド
    def deal_initial_cards
        2.times do
            @player_hand << draw_card
            @dealer_hand << draw_card
        end
    end

    # ランダムにカードを引くメソッド
    def draw_card
        mark = MARKS.sample
        rank = RANKS.sample
        { mark: mark, rank: rank, value: calculate_card_value(rank) }
    end

    # カードの値を計算するメソッド（Aは11として扱うが、後で1として扱うこともある）
    def calculate_card_value(rank)
        return 10 if ['J', 'Q', 'K'].include?(rank)
        return 11 if rank == 'A'
        rank.to_i
    end

    # プレイヤーとディーラーの初期手札を表示するメソッド
    def display_player_and_dealer_hands
        puts "あなたの引いたカードは#{@player_hand[0][:mark]}の#{@player_hand[0][:rank]}です。"
        puts "あなたの引いたカードは#{@player_hand[1][:mark]}の#{@player_hand[1][:rank]}です。"
        puts "ディーラーの引いたカードは#{@dealer_hand[0][:mark]}の#{@dealer_hand[0][:rank]}です。"
        puts "ディーラーの引いた2枚目のカードは分かりません。"
    end

    #プレイヤーの現在の手札と特典を表示するメソッド
    def display_player_hand
        score = calculate_hand_value(@player_hand)
        puts "あなたの現在の得点は#{score}です。"
    end

    # ディーラーの現在の手札と得点を表示するメソッド
    def display_dealer_hand
        score = calculate_hand_value(@dealer_hand)
        puts "ディーラーの現在の得点は#{score}です。"
    end

    # 手札の合計値を計算するメソッド（Aが11として扱われている場合、1に変更する処理も含む）
    def calculate_hand_value(hand)
        values = hand.map { |card| card[:value] } #手札の各カードの値を取り出す
        sum = values.sum # 合計値を計算
        num_aces = values.count { |value| value == 11 } #手札の中のAの数を数える

        # 手札の合計が21を超えていて、Aがまだ11として扱われている場合
        while sum > 21 && num_aces > 0
            sum -= 10 # Aを1に変更
            num_aces -= 1 # 変更したAの数を減らす
        end

        sum # 最終的な合計値を返す
    end

    # プレイヤーのターンを処理するメソッド
    def player_turn
        while true
            display_player_hand # プレイヤーの手札と得点を表示
            puts 'カードを引きますか？(Y/N)'
            choice = gets.chomp.upcase # プレイヤーにカードを引くかどうかの選択を求める
            # upcaseで入力を大文字に変更　chompは入力文字の末尾にある改行文字を取り除く

            if choice == 'Y'
                @player_hand << draw_card # カードを引く
            else
                break # もしNを選択したら、カード引きを終了して次に進む
            end

            # プレイヤーの得点が21を超えたら負け。プログラムを終了
            if calculate_hand_value(@player_hand) > 21
                puts 'あなたの得点が21を超えました。あなたの負けです。'
                exit
            end
        end
    end

    # ディーラーのターンを処理するメソッド
    def dealer_turn
        while calculate_hand_value(@dealer_hand) < 17
            @dealer_hand << draw_card
        end
        puts "ディーラーが引いた2枚目のカードは#{@dealer_hand[1][:mark]}の#{@dealer_hand[1][:rank]}でした。"
    end

    # 勝者を決定して、結果を表示するメソッド
    def determin_winner
        display_player_hand # プレイヤーの手札と得点を表示
        display_dealer_hand # ディーラーの手札と得点を表示

        player_score = calculate_hand_value(@player_hand) #プレイヤーの手札の合計値を計算
        dealer_score = calculate_hand_value(@dealer_hand) #ディーラーの手札の合計値を計算
        
        # プレイヤーの得点が21を超えたら負け
        if player_score > 21
            puts "あなたの得点が21を超えました。あなたの負けです。"
        elsif dealer_score > 21 || player_score > dealer_score
            puts "あなたの勝ちです！"
        elsif player_score < dealer_score
            puts "ディーラーの勝ちです！"
        else
            puts "引き分けです。"
        end
    end
end

# ゲームの開始
game = BlackjackGame.new
game.start