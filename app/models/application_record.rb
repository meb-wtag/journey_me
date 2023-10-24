class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
