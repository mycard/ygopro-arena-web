class BoardsController < ApplicationController
  #ApplicationHelper::addon_header.push "zh_header"
  #ApplicationHelper::addon_top.push "zh_top"
  #ApplicationHelper::addon_footer.push "zh_footer"
  # GET /boards
  # GET /boards.xml
  def index
    @boards = Board.where(:superboard_id => 0)
    @links = Link.all
    @actions = []
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.xml
  def show
    
    @board = Board.find(params[:id])
    @actions = [@board]
    order = params[:order].blank? ? 'displayorder DESC, updated_at DESC' : params[:order]
    @topics = @board.topics.page(params[:page]).order(order)
    #@topics = @board.topics.all(:offset => 20*@page-20, :limit => 20, :order => order)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => params[:page] && !params[:page].empty? ? @topics : @board}
    end
  end

  # GET /boards/new
  # GET /boards/new.xml
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
    @actions = [@board, :edit]
  end

  # POST /boards
  # POST /boards.xml
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
        format.html { redirect_to(@board, :notice => 'Board was successfully created.') }
        format.xml  { render :xml => @board, :status => :created, :location => @board }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.xml
  def update
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to(@board, :notice => 'Board was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.xml
  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to(boards_url) }
      format.xml  { head :ok }
    end
  end
end
