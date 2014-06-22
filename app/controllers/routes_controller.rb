class RoutesController < ApplicationController
  
  def index
    @routes = Route.all
  end

  def show
    @route = Route.find_by_number(params[:id])
    @all_routes = { total_boardings: Route.total_boardings,
                    total_alightings: Route.total_alightings }
    @all_routes[:percent_boardings] = (@route.total_boardings * 100 / @all_routes[:total_boardings]).round(2)
    @all_routes[:percent_alightings] = (@route.total_alightings * 100 / @all_routes[:total_alightings]).round(2)
  end

  def raw_analysis
    @table_data_raw = 
  end
end
