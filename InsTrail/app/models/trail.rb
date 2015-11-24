class Trail < ActiveRecord::Base
  belongs_to :map
  has_many :photos

  def get_lat
  	return @lat
  end

  def get_lon
  	return @lon
  end

  def get_name
    return @name
  end
    # getter for count
  def get_count
	return @count
  end

end