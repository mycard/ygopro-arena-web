class TopicsController < ApplicationController
  ApplicationHelper::addon_header.push "zh_header"
  ApplicationHelper::addon_top.push "zh_top"
  ApplicationHelper::addon_footer.push "zh_footer"
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @page = params[:page] && !params[:page].empty? ? params[:page].to_i : 1
    @topic = Topic.find(params[:id])
    @actions = [@topic.category, @topic]
    @posts = Post.find_all_by_topic_id(params[:id], :offset => 10*@page-10, :limit => 10, :order => :displayorder)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => params[:page] && !params[:page].empty? ? @posts : @topic }
    end
  end

  # GET /forum/id/new
  # GET /forum/id/new.xml
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /board/id
  # POST /board/id.xml
  def create
    @topic = Topic.new(params[:topic])
    #@topic.category_id = Board.find(params[:topic][:category_id])
    @topic.user = @correct_user
    @topic.displayorder = 0
    
    @post = Post.new(params[:post])
    @post.displayorder = 1
    @post.topic = @topic
    @post.user = @correct_user

    respond_to do |format|
      if @topic.save && @post.save
        format.html { redirect_to(@topic, :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end
end
