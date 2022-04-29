class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.all_for_user(user)
    self.where("user_id = #{user.id}")
  end
end
