#encoding: UTF-8
class UsersController < ApplicationController
  require 'open-uri'
  layout 'ygo'
  #ApplicationHelper::addon_header.push "zh_header"
  #ApplicationHelper::addon_top.push "zh_top"
  #ApplicationHelper::addon_footer.push "zh_footer"
  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @actions = [{"YGO战网" => users_path}, "用户排行"]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @actions = [{"YGO战网" => users_path}, @user]
    respond_to do |format|
      format.html # show.html.erb
      #format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @actions = ["注册"]
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
    
    #验证ygocore服务器是否可注册，true为成功，false为重名，nil为异常
    success = open("http://140.113.242.66:7922/?userregist=NEW&username=#{CGI.escape @user.name}&password=#{CGI.escape @user.password}") do |file|
      file.set_encoding("GBK")
      case file.read.encode("UTF-8")
      when "注册成功"
        open("http://140.113.242.66:7922/?pass=zh99998&operation=saveuser"){} rescue nil
        true
      when "用户已存在"
        @user.errors.add :name, "用户已存在"
        false
      else
        nil
      end
    end rescue nil
    @user.errors.add :name, "注册失败，可能是服务器故障，请与管理员联系 Email/GT/QQ: zh99998@gmail.com" if success.nil?
    
    respond_to do |format|
      if success and @user.save
        session[:user_id] = @user.id
        format.html { redirect_to(@user, :notice => '注册成功') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
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
    @actions = ["登陆"]
    @user = User.new
  end
  def login_do
    @actions = ["登陆"]
    user = User.find_by_name(params[:user][:name])
    if user and params[:user][:password] == user.password
      @user = user
    elsif user.nil? or user.password.nil?
      username = params[:user][:name]
      password = params[:user][:password]
      open("http://140.113.242.66:7922/?operation=passcheck&username=#{CGI.escape username}&pass=#{CGI.escape password}") do |file|
        file.set_encoding("GBK")
        case file.read.encode("UTF-8")
        when "true"
          if user
            user.password = password
            @user = user
            @user.save
          else
            @user = User.create(:name => username, :password => password)
          end
        end
      end rescue nil
    end
    respond_to do |format|
      if @user
        session[:user_id] = @user.id
        @user.update_attribute(:lastloginip, request.remote_ip)
        format.html { redirect_to(@user, :notice => 'Login Successfully.') }
        format.xml  { head :ok }
      else
        @user = User.new(params[:user])
        #@user.errors.add 'incorrent_username_or_password' #TODO: 查API
        return render :text => 'incorrent_username_or_password'
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
    #p params[:theme], @site[:themes].has_key?(params[:theme])
    if params[:theme].blank?
      cookies[:theme] = nil
      @current_user.update_attribute(:theme, nil)
    elsif @site[:themes].has_key? params[:theme]
      cookies[:theme] = params[:theme]
      @current_user.update_attribute(:theme, params[:theme])
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
