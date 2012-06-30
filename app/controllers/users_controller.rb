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
    @from = params[:from]
    respond_to do |format|
      if !@user.errors.any? and @user.save
        remote_register(@user, @from)
        session[:user_id] = @user.id
        format.html { redirect_to(params[:continue].blank? ? @user : params[:continue].gsub(/\{name\}|\{password\}/, '{name}' => URI.encode_www_form_component(@user.name), '{password}' => URI.encode_www_form_component(@user.password)), :notice => '注册成功') }
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
    @continue = params[:continue]
    return @user = User.new if params[:user].blank?
    @actions = [User.human_attribute_name(:login)]

    name = params[:user][:name]
    password = params[:user][:password]

    user = User.find_by_name(name)
    if user and user.password.blank? and remote_login(name, password)
      #远程登录
      @user = User.find_by_name(name)
      @user.update_attribute(:password, password)
    elsif user and user.password == password
      #本地登录
      @user = user
    end

    respond_to do |format|
      if @user
        session[:user_id] = @user.id
        @user.update_attribute(:lastloginip, request.remote_ip)
        remote_register(@user)
        format.html { redirect_to(params[:continue].blank? ? @user : params[:continue].gsub(/\{name\}|\{password\}/, '{name}' => URI.encode_www_form_component(@user.name), '{password}' => URI.encode_www_form_component(@user.password)), :notice => 'Login Successfully.') }
        format.json { render json: @user }
      else
        @user = User.new(params[:user])
        @user.errors[:base] << '用户名或密码错误'
        format.html
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

  def remote_register(user, from=nil)
    Server.all.each do |server|
      url = server.register.gsub /\{key\}|\{id\}|\{name\}|\{password\}|\{email\}/, '{key}' => URI.encode_www_form_component(server.key), '{id}' => URI.encode_www_form_component(user.id), '{name}' => URI.encode_www_form_component(user.name), '{password}' => URI.encode_www_form_component(user.password), '{email}' => URI.encode_www_form_component(user.email)
      if from == server.name
        open(url) {}
      else
        Thread.new { open(url) {} }
      end
    end
  end

  def remote_login(name, password, from=nil)
    servers = Server.where("login is not null")
    servers = servers.where(name: from) if from
    servers.each do |server|
      url = server.login.gsub /\{key\}|\{name\}|\{password\}/, '{key}' => URI.encode_www_form_component(server.key), '{name}' => URI.encode_www_form_component(name), '{password}' => URI.encode_www_form_component(password)
      open(url) { |f| return server if f.read == "true" }
    end
    nil
  end
end