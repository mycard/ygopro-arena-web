#encoding: UTF-8
class DuelsController < ApplicationController
  layout 'ygo'
  # GET /duels
  # GET /duels.json
  def index
    if params[:user_id]
      @user = User.find params[:user_id]
      @duels = @user.duels
      @actions = [{t('mycard.battlenet') => users_path}, @user, Duel.human_attribute_name(:index)]
    else
      @duels = Duel.where(true)
      @actions = [{t('mycard.battlenet') => users_path}, Duel.human_attribute_name(:index)]
    end
    @duels = @duels.reverse_order.page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @duels }
    end
  end

  # GET /duels/1
  # GET /duels/1.json
  def show
    @duel = Duel.find(params[:id])
    @actions = [{t('mycard.battlenet') => users_path}, {Duel.human_attribute_name(:index) => duels_path}, @duel]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @duel }
    end
  end

  # GET /duels/new
  # GET /duels/new.json
  def new
    @duel = Duel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @duel }
    end
  end

  # GET /duels/1/edit
  def edit
    @duel = Duel.find(params[:id])
  end

  # POST /duels
  # POST /duels.json
  def create
    @duel = Duel.new
    @duel.winreason = params[:duel][:winreason]
    @duel.replay = params[:duel][:replay]
    @duel.version = params[:duel][:version]
    @duel.user1 = User.find_by_name params[:duel][:user1_name] if params[:duel][:user1_name]
    @duel.user2 = User.find_by_name params[:duel][:user2_name] if params[:duel][:user2_name]
    return if @duel.user1 == @duel.user2
    card_numbers_arr = [params[:duel][:user1_main], params[:duel][:user1_extra], params[:duel][:user2_main], params[:duel][:user2_extra]]
    card_numbers = []
    card_numbers_arr.each do |zone|
      card_numbers += zone.split(',')
    end
    sql = Card.where(number: card_numbers).select([:id, :number]).order(:id).group(:number).to_sql
    card_number_id = {}
    Duel.connection.execute(sql).each do |id, number|
      card_number_id[number] = id
    end
    card_numbers_arr.each_with_index do |cards, index|
      user = index / 2 == 0 ? @duel.user1 : @duel.user2
      main = index % 2 == 0
      cards.split(',').collect do |card_number|
        card_number = card_number.to_i
        if !card_number_id[card_number]
          Card.create(:id => card_number, :name => card_number, :number => card_number)
          card_number_id[card_number] = card_number
        end
        @duel.duel_user_cards << DuelUserCard.new(user: user, card_id: card_number_id[card_number], main: main)
      end
    end
    @duel.winner = params[:duel][:winner_pos] == "true" ? @duel.user1 : @duel.user2

    if @duel.winner == @duel.user1
      if @duel.user2.credits <= 0
        @duel.user1_credits = 3
        @duel.user2_credits = -1
      elsif @duel.user2.credits <= 10
        @duel.user1_credits = 5
        @duel.user2_credits = -2
      else
        @duel.user1_credits = 10
        @duel.user2_credits = -4
      end
      if params[:duel][:credits] == "false"
        @duel.user2_credits = -5
      end
    else
      if @duel.user1.credits <= 0
        @duel.user2_credits = 3
        @duel.user1_credits = -1
      elsif @duel.user1.credits <= 10
        @duel.user2_credits = 5
        @duel.user1_credits = -2
      else
        @duel.user2_credits = 10
        @duel.user1_credits = -4
      end
      if params[:duel][:credits] == "false"
        @duel.user1_credits = -5
      end
    end

    if @duel.user1
      @duel.user1.update_attribute(:credits, @duel.user1.credits + @duel.user1_credits)
    end
    if @duel.user2
      @duel.user2.update_attribute(:credits, @duel.user2.credits + @duel.user2_credits)
    end
    #p @duel.user1
    #p @duel.user2
    #STDIN.gets
    @duel.created_at = Time.zone.parse params[:duel][:created_at]
    respond_to do |format|
      if @duel.save
        format.html { redirect_to @duel, notice: 'Duel was successfully created.' }
        format.json { render json: @duel, status: :created, location: @duel }
      else
        format.html { render action: "new" }
        format.json { render json: @duel.errors, status: :unprocessable_entity }
      end
    end
  end

# PUT /duels/1
# PUT /duels/1.json
  def update
    @duel = Duel.find(params[:id])
    case @current_user
      when @duel.user1
        params[:duel] = {:user1_public => params[:duel][:user1_public]}
      when @duel.user2
        params[:duel] = {:user2_public => params[:duel][:user2_public]}
      else
        params[:duel] = {}
    end
    respond_to do |format|
      if @duel.update_attributes(params[:duel])
        format.html { redirect_to @duel, notice: 'Duel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @duel.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /duels/1
# DELETE /duels/1.json
  def destroy
    @duel = Duel.find(params[:id])
    @duel.destroy

    respond_to do |format|
      format.html { redirect_to duels_url }
      format.json { head :no_content }
    end
  end

  def user_deck(user_pos)
    @duel = Duel.find(params[:duel_id])
    unless (user_pos and @duel.user1_public or @duel.user1 == @current_user) or (!user_pos and @duel.user2_public or @duel.user2 == @current_user)
      return respond_to do |format|
        format.ydk { redirect_to :format => :html }
        format.html { render :text => "卡组未公开" }
      end
    end
    if user_pos
      main = @duel.user1_main
      extra = @duel.user1_extra
    else
      main = @duel.user2_main
      extra = @duel.user2_extra
    end

    respond_to do |format|
      format.html { render :text => (["#created by ...", "#main"] + main.collect { |card| card.number } + ["#extra"] + extra.collect { |card| card.number } + ["!side"]).join("\r\n") }
      format.ydk { render :text => (["#created by ...", "#main"] + main.collect { |card| card.number } + ["#extra"] + extra.collect { |card| card.number } + ["!side"]).join("\r\n") }
    end
  end

  def user1_deck
    user_deck(true)
  end

  def user2_deck
    user_deck(false)
  end

end
