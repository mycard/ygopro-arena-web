class Role < ActiveRecord::Base
  def to_s
    "<em>#{name}</em>".html_safe
  end
end
