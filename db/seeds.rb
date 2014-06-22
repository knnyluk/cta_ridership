# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
bus_stops = CSV.read("db/oct2012.csv", headers:true)
bus_stops.each_with_index do |bs, i|
  p i
  bs_hash = bs.to_hash
  lat, long = bs_hash['location'].delete('()').split(', ')
  routes = bs_hash['routes'].split(',')
  current_stop = Stop.create( stop_id: bs_hash['number'],
                              street_on: bs_hash['street_on'],
                              street_cross: bs_hash['street_cross'],
                              boardings: bs_hash['boardings'],
                              alightings: bs_hash['alightings'],
                              lat: lat,
                              long: long,
                              route_count: routes.length)
  routes.each do |route|
    route.strip!
    if route != ''
      current_stop.routes << ( Route.find_by_number(route) || 
                               Route.create(number: route) )
    end
  end
end

Route.find_each do |r|
  r.update(stop_count: r.stops.count,
           total_alightings: r.stops.map(&:alightings).reduce(:+).round(1),
           total_boardings: r.stops.map(&:boardings).reduce(:+).round(1))
end


# Route.all.map {|r| [r.number, r.stops.count] }.sort {|a,b| b[1] <=> a[1]}

# no route number for stop 6637
# no route number for stop 12548, duplicated row?