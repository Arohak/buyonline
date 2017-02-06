class Get::ParsedeliveryController < ApplicationController

  def parse
    url = $ROOT_URL + GET_DELIVERY + "?lng=#{params[:lng]}"
    response  = RestClient.get url
    response = getCorrectText(response)
    json = JSON.parse(response)
    deliveries  = json['regions']

    parseDeliveries(deliveries)

    render text: 'OK'
  end

  def getCorrectText(text)
    s = 22
    e = text.mb_chars.length - 1
    str = text[s...e]

    return str
  end

  def parseDeliveries(deliveries)
    if Delivery.all.count > 0
      deliveries.each do |delivery|
        d = Delivery.find(delivery['id'])
        d.update(city:        delivery['city'],
                 alias:       delivery['alias'],
                 price:       delivery['price'])
      end
    else
      deliveries.each do |delivery|
        Delivery.create(city:           delivery['city'],
                        alias:          delivery['alias'],
                        price:          delivery['price'])
      end
    end

  end

  def renderDeliveries
    deliveries = Delivery.all

    render json: deliveries
  end

end
