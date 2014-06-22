class Stop < ActiveRecord::Base
  has_and_belongs_to_many :routes

  def self.most_routes(quantity=1)
    result = order(route_count: :desc).limit(quantity)
    quantity == 1 ? result.first : result
  end

  def board_alight
    [boardings, alightings]    
  end

  def route_numbers
    routes.map(&:number)
  end

  def self.most_alightings
    order(alightings: :desc).limit(1)
  end

end
