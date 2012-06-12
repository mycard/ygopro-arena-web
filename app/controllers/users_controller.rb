#encoding: UTF-8
class UsersController < ApplicationController
  require 'open-uri'
  layout 'ygo'

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @actions = [{t('mycard.battlenet') => users_path}, User.human_attribute_name(:index)]
    respond_to do |format|
      format.html # index.html.erb
                  #format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_id(params[:id]) || User.find_by_name(params[:id])
    @actions = [{t('mycard.battlenet') => users_path}, @user]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => {id: @user.id, name: @user.name, nickname: @user.nickname} }
      format.png { redirect_to @user.avatar.url(:middle) }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @actions = [User.human_attribute_name(:register)]
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    if @current_user != User::Guest
      @user = User.find(params[:id])
      @actions = [@user, "修改头像"]
      if @current_user != @user
        respond_to do |format|
          format.html { redirect_to(edit_user_path(@current_user), :notice => '请先登录.') }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to(:login, :notice => '请先登录.') }
      end
    end

  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    #不知道什么原因，加了devise之后那两个字段就奇怪的变成空了
    #@user.name = params[:user][:name]
    #@user.password = params[:user][:password]
    @actions = [User.human_attribute_name(:register)]
    @continue = params[:continue]
    @from = params[:from].to_s.to_sym
    respond_to do |format|
    #  open("http://ygopro-ocg.com/mycard.php?key=zh99998&username=#{CGI.escape @user.name}&password=#{CGI.escape @user.password}&email=#{CGI.escape @user.email}") do |f|
    #    result = f.read
    #    if result.to_i <= 0
    #      @user.errors[:base] << "发生系统错误 (#{result}) 请联系zh99998@gmail.com"
    #    end
    #  end rescue @user.errors[:base] << "发生系统错误 (#{$!.inspect}) 请联系zh99998@gmail.com"
      if !@user.errors.any? and @user.save
        boardcast_user(@user, :"ygopro-ocg")
        session[:user_id] = @user.id
        format.html { redirect_to(params[:continue].blank? ? @user : URI.escape(params[:continue]) , :notice => '注册成功') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    if @user == @current_user
      if !params[:user][:theme].blank? && @site[:themes].has_key?(params[:theme])
        cookies[:user][:theme] = params[:theme]
      end
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(:back, :notice => 'User was successfully updated.') }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to(:back, :notice => '只能修改自己的头像') }
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
      format.xml { head :ok }
    end
  end

  def login
    @actions = [User.human_attribute_name(:login)]
    return @user = User.new if params[:user].blank?
    @actions = [User.human_attribute_name(:login)]
    user = User.find_by_name(params[:user][:name])
    if user and params[:user][:password] == user.password
      @user = user
    elsif user.nil? or user.password.nil?
      username = params[:user][:name]
      password = params[:user][:password]
      Server.all.each do |server|
        open("http://#{server.ip}:#{server.http_port}/?operation=passcheck&username=#{CGI.escape username}&pass=#{CGI.escape password}") do |file|
          if file.read == "true"
            user.password = password
            @user = user
            @user.save
            break
          end
        end rescue nil
        break if @user
      end
    end
    respond_to do |format|
      if @user
        session[:user_id] = @user.id
        @user.update_attribute(:lastloginip, request.remote_ip)
        boardcast_user(@user)
        format.html { redirect_to(params[:continue].blank? ? @user : URI.escape(params[:continue]), :notice => 'Login Successfully.') }
        format.json { render json: @user }
      else
        @user = User.new(params[:user])
        format.html { render :text => 'incorrent_username_or_password' }
        format.json { head json: nil }
      end
    end
  end

  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml { head :ok }
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
      format.xml { head :ok }
    end
  end

  def boardcast_user(user, from=nil)
    Server.find_each do |server|
      url = "http://#{server.ip}:#{server.http_port}/?pass=#{server.password}&operation=forceuserpass&username=#{CGI.escape user.name}&password=#{CGI.escape user.password}"
      if RUBY_PLATFORM["win"] || RUBY_PLATFORM["ming"]
        open(url) {} rescue nil
      else
        Process.spawn('curl', url)
      end
    end
    if from != :"ygopro-ocg"
      url = "http://ygopro-ocg.com/mycard.php?key=zh99998&username=#{CGI.escape user.name}&password=#{CGI.escape user.password}&email=#{CGI.escape user.email}"
      if RUBY_PLATFORM["win"] || RUBY_PLATFORM["ming"]
        open(url) {}
      else
        Process.spawn('curl', url)
      end
    end
  end
end