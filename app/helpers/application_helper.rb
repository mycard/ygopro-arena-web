module ApplicationHelper
  def logged?
    @correct_user.id != 0
  end
end