#encoding: UTF-8
class DuelsController < ApplicationController
  layout 'ygo'
  # GET /duels
  # GET /duels.json
  def index
    if params[:user_id]
      @user = User.find params[:user_id] 
      @duels = @user.duels
      @actions = [{"YGO战网" => users_path}, @user, '对战列表']
    else
      @duels = Duel.where(true)
      @actions = [{"YGO战网" => users_path}, '对战列表']
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
    @actions = [{"YGO战网" => users_path}, {'对战列表' => duels_path}, @duel]
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
    @duel = Duel.new(params[:duel])

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
        format.ydk { redirect_to :format => :html}
        format.html{ render :text => "卡组未公开"}
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
      format.html{ render :text => (["#created by ...", "#main"] + main.collect{|card|card.number} + ["#extra"] + extra.collect{|card|card.number} + ["!side"]).join("\r\n")}
      format.ydk { render :text => (["#created by ...", "#main"] + main.collect{|card|card.number} + ["#extra"] + extra.collect{|card|card.number} + ["!side"]).join("\r\n")}
    end
  end
  def user1_deck
    user_deck(true)
  end
  def user2_deck
    user_deck(false)
  end
end
