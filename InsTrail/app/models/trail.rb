class Trail < ActiveRecord::Base
  has_many :photo
  belongs_to :map
end
