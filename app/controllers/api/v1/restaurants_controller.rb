class API::V1::RestaurantsController < ApplicationController

  def index
    l       = params[:limit]
    o       = params[:offset]
    type    = params[:type]

    case type
      when 'new'
        @restaurants =  Restaurant.where(new: true).limit(l).offset(o)
      when 'rate'
        @restaurants =  Restaurant.where(rate: 4).limit(l).offset(o)
      when 'open'
        @restaurants =  Restaurant.where(status: 'open').limit(l).offset(o)
      when 'all'
        @restaurants =  Restaurant.all.limit(l).offset(o)
      when nil
        if params[:search]
          @restaurants =  Restaurant.search(params[:search]).limit(l).offset(o)
        else
          @restaurants =  Restaurant.all.limit(l).offset(o)
        end
    end

    data = @restaurants.to_json(include: [:categoryitems, :addresses])

    render_response(JSON(data), 'SUCCESS', '')
  end

  def show
    restaurant = Restaurant.find(params[:id])
    data = restaurant.to_json(include: [:categoryitems, :addresses])

    render_response(JSON(data), 'SUCCESS', '')
  end

  def nearst
    latitude  = params[:latitude].to_s.to_d
    longitude = params[:longitude].to_s.to_d
    m         = params[:km].to_s.to_d * 1000

    restaurants = Array.new
    addresses = Array.new

    Restaurant.all.each do |restaurant|
      addresses.clear
      restaurant.addresses.each do |address|
        unless address.nil? && address.nil?
          meter = distance_between(latitude, longitude, address.latitude, address.longitude)
          if !meter.nil? && meter < m

            add = {id: address.id,
                   restaurant_id: address.restaurant_id,
                   name: address.name,
                   latitude: address.latitude,
                   longitude: address.longitude,
                   distance: meter}

            addresses << add
          end
        end
      end
      if !addresses.empty?
        rest = {id: restaurant.id,
                restaurant_id: restaurant.restaurant_id,
                label: restaurant.label,
                description: restaurant.description,
                status: restaurant.status,
                new: restaurant.new,
                rate: restaurant.rate,
                src: restaurant.src,
                addresses: addresses.clone,
                categoryitems: restaurant.categoryitems}

        restaurants << rest
      end
    end

    render_response(restaurants, 'SUCCESS', '')
  end

  def distance_between(lat1, lon1, lat2, lon2)
    rad_per_deg = Math::PI / 180
    rm = 6371000 # Earth radius in meters

    lat1_rad, lat2_rad = lat1 * rad_per_deg, lat2 * rad_per_deg
    lon1_rad, lon2_rad = lon1 * rad_per_deg, lon2 * rad_per_deg

    a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

    rm * c # Delta in meters
  end

end