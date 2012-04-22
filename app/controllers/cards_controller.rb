#encoding: UTF-8
class CardsController < ApplicationController
  layout 'ygo'
  # GET /cards
  # GET /cards.json
  def index
    if params[:user_id]
      @user = User.find params[:user_id]
      @cards = @user.cards
      @actions = [{"YGO战网" => users_path}, @user, "常用卡片"]
    else
      @cards = Card.joins(:duel_user_cards)
      @actions = [{"YGO战网" => users_path}, "卡片排行"]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])
    @actions = [{"YGO战网" => users_path}, {"卡片列表" => cards_path}, @card]
    respond_to do |format|
      format.html { redirect_to "http://www.ourocg.cn/Cards/View-#{@card.id}"}
      format.json { render json: @card }
      format.png { redirect_to @card.image }
    end
  end
  
  def search
    @cards = Card.where(:name => params[:name].split(','))
    respond_to do |format|
      #format.html { render }
      format.json { render json: @cards }
      format.jsonp { render text: "#{params[:callback]}(#{@cards.to_json})" }
    end
  end
  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(params[:card])

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end
end
