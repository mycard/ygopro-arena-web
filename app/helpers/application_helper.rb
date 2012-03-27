module ApplicationHelper
  def logged?
    @current_user != User::Guest
  end
end