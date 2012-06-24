class Deck < ActiveRecord::Base
  belongs_to :library
  belongs_to :origin, :polymorphic => true
  has_and_belongs_to_many :cards

  def self.parse(contents, extname)
    side = false
    card_ids = []
    card_sides = []
    case extname.downcase
      when ".ydk"
        card_numbers = []
        contents.each_line do |line|
          line.chomp!
          next if line[0, 1] == "#"
          next side = true if line == "!side"
          number = line.to_i
          next if number == 0
          card_numbers << number
          card_sides << side
        end
        sql = Card.where(number: card_numbers.uniq).select([:id, :number]).order(:id).group(:number).to_sql
        card_number_id = {}
        Deck.connection.execute(sql).each { |id, number| card_number_id[number] = id }
        card_numbers.each do |number|
          id = card_number_id[number]
          if id.nil?
            Card.create(id: number, name: number, number: number)
            card_number_id[number] = number
          end
          card_ids << card_number_id[number]
        end
      when ".deck", ".txt"
        card_names = []
        contents.force_encoding("GBK").encode("UTF-8").each_line do |line|
          line.chomp!
          next side = true if line == "####"
          next side = false if line == "===="
          break if line == "$$$$"
          line =~ /\[(.*)\]/
          name = $1
          card_names << name
          card_sides << side
        end
        sql = Card.where(name: card_names.uniq).select([:id, :name]).order(:id).group(:name).to_sql
        card_name_id = {}
        Deck.connection.execute(sql).each { |id, name| card_name_id[name] = id }
        card_names.each do |name|
          card_ids << card_name_id[name]
        end
    end
    result = Deck.create
    deck_id = result.id
    sql = "INSERT INTO decks_cards (deck_id, card_id, side) VALUES "
    card_sides = card_sides.to_enum
    card_ids.each do |card_id|
      next card_sides.next if card_id.nil?
      sql << "(#{deck_id}, #{card_id}, #{card_sides.next}),"
    end
    sql[-1, 1] = ';'
    Deck.connection.execute(sql)
    result
  end
end
