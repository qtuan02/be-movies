class Room
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :cinema

end
