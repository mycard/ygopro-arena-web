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
  
  
  #主题管理：
  #删除：/topic/control?id=1&deleted=1
  #反删除：/topic/control?id=1&deleted=0
  #置顶 3 /topic/control?id=1&displayorder=3
  #沉底 /topic/control?id=1&displayorder=-1
  #恢复正常排序 /topic/control?id=1&displayorder=-1
  #高亮 /topic/control?id=1&highlight=  //TODO
  #精华 3 /topic/control?id=1&digest=3
  #取消精华 /topic/control?id=1&digest=0
  #锁定 /topic/control?id=1&locked=1
  #打开 /topic/control?id=1&locked=0
  #移动 /topic/control?id=1&category_id=1
  #分类 /topic/control?id=1&type_id=1
  #以上操作可以多重进行
  #例如把1,2,3号id的主题进行精华3和置顶1
  #/topic/control?id=1,2,3&digest=3&displayorder=1
  Data_Control = ['deleted', 'displayorder', 'highlight', 'digest', 'locked', 'category_id', 'type_id']
  def control
    if params['id']
      id = params['id'].split(/,/)
      return if id.empty?
    else
      return
    end
    data_control = {}
    Data_Control.each do |key| #喵你妹的Hash不带交集运算
      data_control[key] = params[key] if params[key]
    end
    unless data_control.empty?
      @topics = Topic.update_all(data_control, {:id => id})
    end
    if params['merge']
      #TODO
    end
    if params['split']
      #TODO
    end
  end
end
