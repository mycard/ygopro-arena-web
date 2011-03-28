module ApplicationHelper
  def logged?
    @correct_user.id
  end
end