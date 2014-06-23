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

  def self.stops_by_boardings
    Stop.all.order(boardings: :desc)
  end

  def boardings_rank
    boardings = Stop.stops_by_boardings
    "#{boardings.index(self) + 1} / #{boardings.length}"
  end

  def self.stops_by_alightings
    Stop.all.order(alightings: :desc)
  end

  def alightings_rank
    alightings = Stop.stops_by_alightings
    "#{alightings.index(self) + 1} / #{alightings.length}"
  end

  def self.stops_by_route_count
    all.order(route_count: :desc)
  end

  def routes_rank
    stops = Stop.stops_by_route_count
    "#{stops.index(self)} / #{stops.length}"
  end

end
