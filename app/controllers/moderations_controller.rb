class ModerationsController < ApplicationController
  # GET /moderations
  # GET /moderations.xml
  def index
    @moderations = Moderation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @moderations }
    end
  end

  # GET /moderations/1
  # GET /moderations/1.xml
  def show
    @moderation = Moderation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @moderation }
    end
  end

  # GET /moderations/new
  # GET /moderations/new.xml
  def new
    @moderation = Moderation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @moderation }
    end
  end

  # GET /moderations/1/edit
  def edit
    @moderation = Moderation.find(params[:id])
  end

  # POST /moderations
  # POST /moderations.xml
  def create
    @moderation = Moderation.new(params[:moderation])
    @moderation.user = @correct_user
    case params[:moderation][:assocation_type]
    when "topic"
      #@moderation.association_ = Topic.find params[:moderation][:assocation_id]
      case params[:moderation][:action]
      when "lock"
        @moderation.association.locked = true
      end
    when "post"
      @moderation.association = Post.find params[:moderation][:topic_id]
    when "user"
      @moderation.association = Post.find params[:moderation][:user_id]
    end
    respond_to do |format|
      if @moderation.save && @moderation.association.save
        format.html { redirect_to(@moderation, :notice => 'Moderation was successfully created.') }
        format.xml  { render :xml => @moderation, :status => :created, :location => @moderation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @moderation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /moderations/1
  # PUT /moderations/1.xml
  def update
    @moderation = Moderation.find(params[:id])

    respond_to do |format|
      if @moderation.update_attributes(params[:moderation])
        format.html { redirect_to(@moderation, :notice => 'Moderation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @moderation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /moderations/1
  # DELETE /moderations/1.xml
  def destroy
    @moderation = Moderation.find(params[:id])
    @moderation.destroy

    respond_to do |format|
      format.html { redirect_to(moderations_url) }
      format.xml  { head :ok }
    end
  end
end
