#encoding: UTF-8
class EnrollsController < ApplicationController
  layout 'ygo'
  # GET /enrolls
  # GET /enrolls.json
  def index
    @enrolls = Enroll.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @enrolls }
    end
  end

  # GET /enrolls/1
  # GET /enrolls/1.json
  def show
    @enroll = Enroll.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @enroll }
    end
  end

  # GET /enrolls/new
  # GET /enrolls/new.json
  def new
    @actions = [{"YGO战网" => users_path}, "参加比赛"]
    @enroll = Enroll.new
    @enroll.name = @current_user.name if @current_user.id != 0
    @enroll.tournament = Tournament.find params[:tournament_id] if params[:tournament_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @enroll }
    end
  end

  # GET /enrolls/1/edit
  def edit
    @enroll = Enroll.find(params[:id])
  end

  # POST /enrolls
  # POST /enrolls.json
  def create
    file = params[:enroll][:deck]
    params[:enroll][:deck] = nil
    @enroll = Enroll.new(params[:enroll])
    @enroll.score = -1
    @enroll.user = @current_user
    @enroll.tournament = Tournament.find params[:enroll][:tournament_id]
    if @enroll.tournament.need_deck
      if file
        extname = File.extname file.original_filename
        if [".ydk", ".txt", ".deck"].include?(extname)
          @enroll.deck = Deck.parse(file.read, extname)
          @enroll.deck.name = File.basename(file.original_filename, extname)
        else
          @enroll.errors.add(:deck, '无法识别的卡组,如果你的卡组格式正确依然报此问题,请联系zh99998@gmail.com')
        end
      else
        @enroll.errors.add(:deck, '请上传卡组')
      end
    end
    if @enroll.tournament.need_team and @enroll.team.blank?
      @enroll.errors.add(:team, '不能为空')
    end
    if @enroll.tournament.need_user and @enroll.team.blank?
      @enroll.errors[:base] << '只有注册用户才能参加这个比赛'
    end
    respond_to do |format|
      if !@enroll.errors.any? and @enroll.save
        format.html { redirect_to @enroll.tournament, notice: 'Enroll was successfully created.' }
        format.json { render json: @enroll, status: :created, location: @enroll }
      else
        format.html { render action: "new" }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /enrolls/1
  # PUT /enrolls/1.json
  def update
    @enroll = Enroll.find(params[:id])
    @enroll.tournament = Tournament.find params[:enroll][:tournament_id]
    respond_to do |format|
      if @enroll.update_attributes(params[:enroll])
        format.html { redirect_to @enroll, notice: 'Enroll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolls/1
  # DELETE /enrolls/1.json
  def destroy
    @enroll = Enroll.find(params[:id])
    @enroll.destroy

    respond_to do |format|
      format.html { redirect_to enrolls_url }
      format.json { head :no_content }
    end
  end
end
