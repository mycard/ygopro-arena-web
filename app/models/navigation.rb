class Navigation < ActiveRecord::Base
    belongs_to :super, :class_name => "::Navigation"
    has_many :subs, :class_name => "::Navigation", :foreign_key => :super_id
    default_scope order(:displayorder)
end
