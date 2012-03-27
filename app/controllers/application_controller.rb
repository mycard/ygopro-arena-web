class ApplicationController < ActionController::Base
  Themes_Dir = File.expand_path 'app/themes', Rails.root
  protect_from_forgery
  before_filter :load_settings
  before_filter :load_user
  before_filter :load_locale
  before_filter :load_theme
  
  before_filter :check_actions #for debug
  def check_actions
    @actions = ["warning: no actions here"] unless @actions
  end
  def load_user
    if session[:user_id]
      @current_user = User.find_by_id session[:user_id]
    end
    unless @current_user
      @current_user = User::Guest
    end
  end
  def load_locale
  	#locale = @current_user.locale || (
  	#	request_language = 
    #    request_language && request_language['HTTP_ACCEPT_LANGUAGE'][/[^,;]+/]
    #)
    I18n.locale = 'zh-CN'#locale if File.exist?("#{::Rails.root}/config/locales/#{request_language}.yml") 
    User::Guest.name = t 'user.guest'
    #IE && FF are not support
  end 
  def load_theme
    case #TODO: DRY
    when @site[:themes].has_key?(cookies[:theme])
      prepend_view_path File.join Themes_Dir, cookies[:theme]
    when @site[:themes].has_key?(@current_user.theme)
      prepend_view_path File.join Themes_Dir, @current_user.theme
    when @site[:themes].has_key?(@site.theme)
      prepend_view_path File.join Themes_Dir, @site.theme
    end
  end
  def load_settings
  	@site = {
  		:name => "Mycard", 
  		:theme => nil,
  	}
  	def @site.method_missing(method, *args)
      self[method]# || super
    end
    def @site.to_s
      "<a href=\"/\">#{name}</a>".html_safe
    end
    #cache
    @site[:themes] = {'default' => {}}
    
    Dir.foreach(Themes_Dir) do |file|
      theme_config_file = File.join Themes_Dir, file, "theme.yml"
      if File.file? theme_config_file
        @site[:themes][file] = YAML.load_file(theme_config_file)
      end
    end
    #p @site[:themes]
    
    @navigations = Navigation.find_all_by_super_id 0
  end
  #def redirect_to_thc
  #p 'WARNING: '+params[:anything]+"?"+env['QUERY_STRING']
  #redirect_to("http://www.touhou.cc/bbs/"+params[:anything]+"?"+env['QUERY_STRING'])
  #respond_to do |format|
  #format.html  { render :error => "404" }
  #end
  #end
  alias old_redirect_to redirect_to
  def redirect_to(*args)
    if args.first == :back and env['HTTP_REFERER'].blank?
      old_redirect_to(:root)
    else
      old_redirect_to *args
    end
  end
end