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
  current_stop = Stop.create( street_on: bs_hash['street_on'],
                              street_cross: bs_hash['street_cross'],
                              boardings: bs_hash['boardings'],
                              alightings: bs_hash['alightings'])
  if bs_hash['routes'] 
    bs_hash['routes'].split(',').each do |route|
      route.strip!
      if route != ''
        current_stop.routes << ( Route.find_by_number(route) || 
                                 Route.create(number: route) )
      end
    end
  end
  # current_route = bs_hash['number']
  # ( Route.find_by_number(bs_hash['number']) || 
  #   Route.create(number: bs_hash['number']) ).stops << Stop.create( street_on: bs_hash['street_on'],
  #                                                         street_cross: bs_hash['street_cross'],
  #                                                         boardings: bs_hash['boardings'],
  #                                                         alightings: bs_hash['alightings'])
end

# end