# require 'csv'
# bus_stops = CSV.read("db/oct2012.csv", headers:true)
# bus_stops.each_with_index do |bs, i|
#   p i
#   bs_hash = bs.to_hash
#   lat, long = bs_hash['location'].delete('()').split(', ')
#   routes = bs_hash['routes'].split(',')
#   current_stop = Stop.create( stop_id: bs_hash['number'],
#                               street_on: bs_hash['street_on'],
#                               street_cross: bs_hash['street_cross'],
#                               boardings: bs_hash['boardings'],
#                               alightings: bs_hash['alightings'],
#                               lat: lat,
#                               long: long,
#                               route_count: routes.length,
#                               route_list: bs_hash['routes'])
#   routes.each do |route|
#     route.strip!
#     if route != ''
#       current_stop.routes << ( Route.find_by_number(route) || 
#                                Route.create(number: route) )
#     end
#   end
# end

# Route.find_each do |r|
#   r.update(stop_count: r.stops.count,
#            total_alightings: r.stops.map(&:alightings).reduce(:+).round(1),
#            total_boardings: r.stops.map(&:boardings).reduce(:+).round(1))
# end

# no route number for stop 6637
# no route number for stop 12548, duplicated row
@neo = Neography::Rest.new

Stop.find_each do |s|
  s_node = @neo.create_node(     "stop_id" => s.stop_id, 
                               "street_on" => s.street_on,
                            "street_cross" => s.street_cross,
                                     "lat" => s.lat,
                                    "long" => s.long)
  
  @neo.add_label(s_node, s.routes.map(&:number))
end