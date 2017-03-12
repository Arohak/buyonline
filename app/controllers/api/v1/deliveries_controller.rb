class Api::V1::DeliveriesController < ApplicationController

  def index
    delivery = Delivery.all
    render_response(delivery, 'SUCCESS', '')
  end

end