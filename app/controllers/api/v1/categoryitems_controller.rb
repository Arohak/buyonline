class API::V1::CategoryitemsController < ApplicationController

  def index
    categoryitems = Categoryitem.where(restaurant_id: params[:restaurant_id])
    render_response(categoryitems, 'SUCCESS', '')
  end

end