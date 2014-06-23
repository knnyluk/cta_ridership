class RoutesController < ApplicationController
  
  def index
    @routes = Route.all
  end

  def show
    @route = Route.includes(:stops).find_by_number(params[:id])
    @all_routes = { total_boardings: Route.total_boardings,
                    total_alightings: Route.total_alightings }
    @all_routes[:percent_boardings] = (@route.total_boardings * 100 / @all_routes[:total_boardings]).round(2)
    @all_routes[:percent_alightings] = (@route.total_alightings * 100 / @all_routes[:total_alightings]).round(2)
    @stops = @route.stops
  end

  def analysis
    raw_data = Route.get_raw_data
    raw_table = Route.get_raw_table(raw_data)
    @table_data_raw = Route.raw_analysis(raw_table, raw_data)
  end
end
