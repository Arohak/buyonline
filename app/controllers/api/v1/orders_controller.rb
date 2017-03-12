class Api::V1::OrdersController < ApplicationController

  def index
    if params[:user_id].present?
      order_ids = Order.where(user_id: params[:user_id]).ids
      @order = Order.find(order_ids)
    else
      @order = Order.all
    end
    data = JSON(@order.to_json(include: [:historyproducts]))

    render_response(data, 'SUCCESS', '')
  end

  def update
    order = Order.find(params[:id])
    order.update_attributes(is_verified:      params[:is_verified])

    render_response(order, 'SUCCESS', '')
  end

  def create
    order = Order.create(user_id:             params[:user_id],
                         title:               params[:title],
                         date_create:         params[:date_create],
                         mobile_number:       params[:mobile_number],
                         delivery_address:    params[:delivery_address],
                         delivery_city:       params[:delivery_city],
                         delivery_alias:      params[:delivery_alias],
                         delivery_date:       params[:delivery_date],
                         payment:             params[:payment],
                         orders_total_price:  params[:orders_total_price],
                         delivery_price:      params[:delivery_price],
                         total_price:         params[:total_price],
                         is_verified:         params[:is_verified])

    params[:products].each do |p|
      if p['product_id'].present? && p['count_buy'].present?
        Historyproduct.create(order_id:   order.id,
                              product_id: p['product_id'],
                              count_buy:  p['count_buy'])
      end
    end

    data = JSON(order.to_json(include: [:historyproducts]))

    render_response(data, 'SUCCESS', '')
  end

end