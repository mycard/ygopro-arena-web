class ApplicationController < ActionController::Base
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
  	p request.env['HTTP_ACCEPT_LANGUAGE']
  	#locale = @correct_user.locale || (
  	#	request_language = 
  		#request_language && request_language['HTTP_ACCEPT_LANGUAGE'][/[^,;]+/]
	#)
    #I18n.locale = locale if File.exist?("#{RAILS_ROOT}/config/locales/#{request_language}.yml") 
    User::Guest.name = t 'user.guest'
  end 
  def load_theme
  	if !@correct_user.theme.blank?
  	  theme_path = "app/themes/#{@correct_user.theme}"
  	  prepend_view_path theme_path if File.directory? theme_path
    elsif !@site.theme.blank?
      theme_path = "app/themes/#{@site.theme}"
      prepend_view_path theme_path if File.directory? theme_path
  	end
  end
  def load_settings
  	@site = {
  		:name => "Reliz", 
  		:theme => nil
  	}
  	def @site.method_missing(method, *args)
		self[method]# || super
	end
	def @site.to_s
		"<a href=\"/\">#{name}</a>".html_safe
	end
  end
  def redirect_to_thc
  	  redirect_to("http://www.touhou.cc/bbs/"+params[:anything]+"?"+env['QUERY_STRING'])
  end
end