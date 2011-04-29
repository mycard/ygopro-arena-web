module ApplicationHelper
  def logged?
    @corrent_user != User::Guest
  end
end