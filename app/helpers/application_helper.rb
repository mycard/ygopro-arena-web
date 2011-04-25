module ApplicationHelper
  def logged?
    @correct_user != User::Guest
  end
end