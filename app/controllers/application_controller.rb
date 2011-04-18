class ApplicationController < ActionController::Base
  Themes_Dir = 'app/views/themes'
  
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
      @correct_user = User.find session[:user_id]
    end
    unless @correct_user
      @correct_user = User::Guest
    end
  end
  def load_locale
  	locale = @correct_user.locale || (
  		request_language = 
        request_language && request_language['HTTP_ACCEPT_LANGUAGE'][/[^,;]+/]
    )
    I18n.locale = locale if File.exist?("#{RAILS_ROOT}/config/locales/#{request_language}.yml") 
    User::Guest.name = t 'user.guest'
    #IE && FF are BANNED
  end 
  def load_theme
    case #TODO: DRY
    when @site[:themes].has_key?(cookies[:theme])
      prepend_view_path File.join Themes_Dir, cookies[:theme]
    when @site[:themes].has_key?(@correct_user.theme)
      prepend_view_path File.join Themes_Dir, @correct_user.theme
    when @site[:themes].has_key?(@site.theme)
      prepend_view_path File.join Themes_Dir, @site.theme
    end
  end
  def load_settings
  	@site = {
  		:name => "Reliz", 
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
    p @site[:themes]
  end
  def redirect_to_thc
    redirect_to("http://www.touhou.cc/bbs/"+params[:anything]+"?"+env['QUERY_STRING'])
  end
end