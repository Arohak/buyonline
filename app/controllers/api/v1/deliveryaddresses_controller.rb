class API::V1::DeliveryaddressesController < ApplicationController

  def index
    addresses = Deliveryaddress.all

    render_response(addresses, 'SUCCESS', '')
  end

  def update
    address = Deliveryaddress.find(params[:id])
    address.update_attributes(user_id: params[:user_id],
                              country: params[:country],
                              city:    params[:city],
                              alias:   params[:alias],
                              address: params[:address],
                              def:     params[:def])

    render_response(address, 'SUCCESS', '')
  end

  def create
    address = Deliveryaddress.create(user_id: params[:user_id],
                                     country: params[:country],
                                     city:    params[:city],
                                     alias:   params[:alias],
                                     address: params[:address],
                                     def:     params[:def])

    render_response(address, 'SUCCESS', '')
  end

end