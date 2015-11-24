class Setting < ActiveRecord::Base
	attr_accessible :number
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
