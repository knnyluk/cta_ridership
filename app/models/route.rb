class Route < ActiveRecord::Base
  has_and_belongs_to_many :stops

  def self.most_stops(quantity=1)
    result = order(stop_count: :desc).limit(quantity)
    quantity == 1 ? result.first : result
  end

  def self.stop_count_between(min, max)
    where("stop_count > #{min} AND stop_count < #{max}")
  end

  def total_alightings
    stops.reduce(0) do |total, stop|
      total + stop.alightings
    end
  end

  def total_boardings
    stops.reduce(0) do |total, stop|
      total + stop.boardings
    end
  end

  def total_on_off
    (total_alightings + total_boardings).round(1)
  end

  def self.total_boardings
    sum('total_boardings')
  end

  def self.total_alightings
    sum('total_alightings')
  end

  def alightings
    total_alightings.round(1)
  end

  def boardings
    total_boardings.round(1)
  end

  def self.raw_analysis
     routes = all.map {|r| [r.number,r.stop_count,r.boardings,r.alightings,r.total_on_off]}
     cols = (1..4).to_a.map do |n|
                routes.sort {|a,b| b[n] <=> a[n]}
                      .map {|r| [r[0], r[n]]}
            end
     cols.unshift((1..routes.count).to_a.map(&:to_s))
         .transpose.unshift(['','stop count', 'boardings', 'alightings', 'total on/off']) 
  end


end