class UsersController < ApplicationController
  #ApplicationHelper::addon_header.push "zh_header"
  #ApplicationHelper::addon_top.push "zh_top"
  #ApplicationHelper::addon_footer.push "zh_footer"
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
	@actions = [@user.name]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @actions = [:register]
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        #p session
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        #return render :text => [@user.errors.class, @user.errors]
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    if !params[:user][:theme].blank? && @site[:themes].has_key?(params[:theme])
      cookies[:user][:theme] = params[:theme]
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(:back, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  def login
    @actions = [:login]
    @user = User.new
  end
  def login_do
    @actions = [:login]
    @user = User.find_by_name_and_password(params[:user][:name], params[:user][:password])
    respond_to do |format|
      if @user
        session[:user_id] = @user.id
        format.html { redirect_to(:root, :notice => 'Login Successfully.') }
        format.xml  { head :ok }
      else
        @user = User.new(params[:user])
        #@user.errors.add 'incorrect_username_or_password' #TODO: 查API
        return render :text => 'incorrect_username_or_password'
        format.html { render :action => "login" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
  def theme
    p params[:theme], @site[:themes].has_key?(params[:theme])
    if params[:theme].blank?
      cookies[:theme] = nil
      @correct_user.update_attribute(:theme, nil)
    elsif @site[:themes].has_key? params[:theme]
      cookies[:theme] = params[:theme]
      @correct_user.update_attribute(:theme, params[:theme])
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
