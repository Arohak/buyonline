class Get::ParseaddressController < ApplicationController

  def parse
    ids = [1, 2, 4]
    ids.each do |id|
      response  = RestClient.get "http://videotes.ru/restaurants/get_address.php?id=#{id}"
      addresses = JSON.parse(response)

      parseAddress(id, addresses)
    end

    renderAddresses
    # render text: 'OK'
  end

  def parseAddress(restaurant_id, addresses)
    addresses.each do |address|
      Address.create(restaurant_id:   restaurant_id,
                     name:            address['title'],
                     latitude:        address['ltd'],
                     longitude:       address['lng'])
    end
  end

  def renderAddresses
    address = Address.all

    render json: address
  end

end
