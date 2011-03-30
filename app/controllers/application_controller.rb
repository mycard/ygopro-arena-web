class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_user
  before_filter :check_actions
  before_filter :set_language
  before_filter :load_settings
  def check_actions
    @actions = ["warning: no actions here"] unless @actions
  end
  def check_user
    if session[:user_id]
      @correct_user = User.find session[:user_id]
    end
    unless @correct_user
      @correct_user = User::Guest
    end
  end
  def set_language 
    request_language = request.env['HTTP_ACCEPT_LANGUAGE'] 
    request_language = request_language.nil? ? nil : request_language[/[^,;]+/] 
    # request_language
    I18n.locale = request_language if request_language && File.exist?("#{RAILS_ROOT}/config/locales/#{request_language}.yml") 
    #p I18n.locale, "#{RAILS_ROOT}/config/locales/#{request_language}.yml"
    #p I18n.load_path
    User::Guest.name = t 'user.guest'
  end 
  def load_settings
  	@site = {
  		:name => "Reliz"
  	}
  	def @site.method_missing(method, *args)
		self[method] || super
	end
	def @site.to_s
		"<a href=\"/\">#{name}</a>".html_safe
	end
  end
  def redirect_to_thc
  	  redirect_to("http://www.touhou.cc/bbs/"+params[:anything]+"?"+env['QUERY_STRING'])
  end
end