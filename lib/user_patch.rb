# TODO: which require statement to use here? require_dependency breaks stuff
#require 'user'

# Patches Redmine's Users dynamically.
module UserPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class 
    base.class_eval do
      unloadable
      has_many :rates, :class_name => 'HourlyRate'
    end

  end

  module ClassMethods

  end

  module InstanceMethods
    def current_rate(project_id)
      rate_at(Date.today, project_id)
    end
    
    def rate_at(date, project_id)
      HourlyRate.find(:first, :conditions => [ "user_id = ? and project_id = ? and valid_from <= ?", id, project_id, date], :order => "valid_from DESC")
    end
  end
end