class Setting < ActiveRecord::Base
  belongs_to :user
 # @@customized_popularity = DEFAULT
 #  def initialize(threshold)
 #    super
 #    @@customized_popularity = threshold
 #    return self
 #  end
 #
 #  def self.customized_popularity
 #    @@customized_popularity
 #  end
end
