class Url < ActiveRecord::Base

  validates :url, presence: true, format: { with: URI.regexp}

  def increment_number_of_visits!
    update_attribute(:number_of_visits, self.number_of_visits + 1)
  end

end
