#encoding: UTF-8
RailsAdmin.config do |config|
  config.main_app_name = Proc.new { |controller| [ "Mycard", "管理中心 - #{controller.params[:action].try(:titleize)}" ] }
  config.authenticate_with &:authenticate_admin!
end