class API::V1::ObjectsController < ApplicationController

  def home
    news =  Restaurant.where(new: true).limit(5)
    rates =  Restaurant.where(rate: 4).limit(5)
    opens =  Restaurant.where(status: 'open').limit(5)
    data = { news: news,  rates: rates, opens: opens }

    render_response(data, 'SUCCESS', '')
  end

  def news
    restaurants =  Restaurant.where(new: true)
    data = restaurants.to_json(include: [:categoryitems, :addresses])

    render_response(JSON(data), 'SUCCESS', '')
  end

  def rate
    restaurants =  Restaurant.where(rate: 4)
    data = restaurants.to_json(include: [:categoryitems, :addresses])

    render_response(JSON(data), 'SUCCESS', '')
  end

  def open
    restaurants =  Restaurant.where(status: 'open')
    data = restaurants.to_json(include: [:categoryitems, :addresses])

    render_response(JSON(data), 'SUCCESS', '')
  end

end