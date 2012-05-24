#encoding: UTF-8
RailsAdmin.config do |config|
  config.main_app_name = Proc.new { |controller| [ "Mycard", "管理中心 - #{controller.params[:action].try(:titleize)}" ] }
  class FakeUser
    def self.username
      'admin'
    end

    def self.email
      'zh99998@gmail.com'
    end
  end

  RailsAdmin.config do |config|
    config.current_user_method do
      authenticate_or_request_with_http_basic do |username, password|
        p username, password, username == "admin" && password == "mycard.web"
        username == "admin" && password == "mycard.web"
      end
      FakeUser
    end
    config.authenticate_with{}
  end
end