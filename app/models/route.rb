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

  def self.get_raw_data
    all.map {|r| [r.number,r.stop_count,r.boardings,r.alightings,r.total_on_off]}
  end

  def self.get_raw_table(raw_data)
    (1..4).to_a.map do |n|
      raw_data.sort {|a,b| b[n] <=> a[n]}.map {|r| [r[0], r[n]]}
    end
  end

  def self.raw_totals(raw_data)
    raw_cols = raw_data.transpose
    # { stops: raw_cols[1].map.reduce(:+),
    #   boardings: raw_cols[2].map.reduce(:+),
    #   alightings: raw_cols[3].map.reduce(:+),
    #   on_off: raw_cols[4].map.reduce(:+) }
    (1..4).map {|i| raw_cols[i].reduce(:+)}
  end

  def self.raw_analysis(raw_table, raw_data)
    raw_table.unshift((1..raw_data.count).to_a.map(&:to_s))
         .transpose.unshift(['rank','stop count', 'boardings', 'alightings', 'total on/off']) 
  end

  def self.percent_table
    raw_tab = get_raw_table(get_raw_data).drop(1)
    totals = raw_totals(get_raw_data).drop(1)
    # raw_tab.map.with_index do |col, i| 
    #   col.map {|r| [r.first,(col.last / totals[i])]}
    # end
    raw_tab
  end

  def self.color_class(quantity)
    case quantity
    when 500...1000
      "class=c500"
    else  
      ''
    end
  end

end