class RefereesController < ApplicationController
  layout 'ygo'
  # GET /referees
  # GET /referees.json
  def index
    @referees = Referee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @referees }
    end
  end

  # GET /referees/1
  # GET /referees/1.json
  def show
    @referee = Referee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @referee }
    end
  end

  # GET /referees/new
  # GET /referees/new.json
  def new
    @referee = Referee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @referee }
    end
  end

  # GET /referees/1/edit
  def edit
    @referee = Referee.find(params[:id])
  end

  # POST /referees
  # POST /referees.json
  def create
    params[:referee][:user] = User.find_by_name(params[:referee][:user]) if params[:referee][:user].is_a? String
    @referee = Referee.new(params[:referee])

    respond_to do |format|
      if @referee.save
        format.html { redirect_to @referee.tournament, notice: 'Referee was successfully created.' }
        format.json { render json: @referee, status: :created, location: @referee }
      else
        format.html { render action: "new" }
        format.json { render json: @referee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /referees/1
  # PUT /referees/1.json
  def update
    @referee = Referee.find(params[:id])

    respond_to do |format|
      if @referee.update_attributes(params[:referee])
        format.html { redirect_to @referee, notice: 'Referee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @referee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referees/1
  # DELETE /referees/1.json
  def destroy
    @referee = Referee.find(params[:id])
    @referee.destroy

    respond_to do |format|
      format.html { redirect_to @referee.tournament }
      format.json { head :no_content }
    end
  end
end
