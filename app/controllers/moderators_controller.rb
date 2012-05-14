class ModeratorsController < ApplicationController
  # GET /moderators
  # GET /moderators.json
  def index
    @moderators = Moderator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moderators }
    end
  end

  # GET /moderators/1
  # GET /moderators/1.json
  def show
    @moderator = Moderator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @moderator }
    end
  end

  # GET /moderators/new
  # GET /moderators/new.json
  def new
    @moderator = Moderator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @moderator }
    end
  end

  # GET /moderators/1/edit
  def edit
    @moderator = Moderator.find(params[:id])
  end

  # POST /moderators
  # POST /moderators.json
  def create
    @moderator = Moderator.new(params[:moderator])

    respond_to do |format|
      if @moderator.save
        format.html { redirect_to @moderator, notice: 'Moderator was successfully created.' }
        format.json { render json: @moderator, status: :created, location: @moderator }
      else
        format.html { render action: "new" }
        format.json { render json: @moderator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moderators/1
  # PUT /moderators/1.json
  def update
    @moderator = Moderator.find(params[:id])

    respond_to do |format|
      if @moderator.update_attributes(params[:moderator])
        format.html { redirect_to @moderator, notice: 'Moderator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @moderator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moderators/1
  # DELETE /moderators/1.json
  def destroy
    @moderator = Moderator.find(params[:id])
    @moderator.destroy

    respond_to do |format|
      format.html { redirect_to moderators_url }
      format.json { head :no_content }
    end
  end
end
