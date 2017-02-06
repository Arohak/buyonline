class Get::ParseproductController < ApplicationController

  def parse
    Restaurant.all.each do |r|
      r.categoryitems.each do |m|
        url = $ROOT_URL + "get-restaurant-menu?rest=#{r.restaurant_id.to_s}&restaurant_menu_categories=#{m.rest_id.to_s}" + "&lng=#{params[:lng]}"
        response  = RestClient.get url
        response = getCorrectText(response)
        json = JSON.parse(response)
        products  = json['products']

      parseProducts(m, products)
      end
    end

    render text: 'OK'
  end

  def translation
    Restaurant.all.each do |r|
      r.categoryitems.each do |m|
        url = $ROOT_URL + "get-restaurant-menu?rest=#{r.restaurant_id.to_s}&restaurant_menu_categories=#{m.rest_id.to_s}" + "&lng=#{params[:lng]}"
        response  = RestClient.get url
        response = getCorrectText(response)
        json = JSON.parse(response)
        products  = json['products']

        updateProducts(m, products)
      end
    end

    render text: 'OK'
  end

  def getCorrectText(text)
    s = 22
    e = text.mb_chars.length - 1
    str = text[s...e]

    return str
  end

  def parseProducts(categoryitem, products)
    products.each do |product|
      Product.create(product_id:                  product['id'],
                     rest_id:                     product['rest_id'],
                     categoryitem_id:             categoryitem.id,
                     restaurant_menu_categories:  product['restaurant_menu_categories'],
                     label:                       product['label'],
                     item_number:                 product['item_number'],
                     inventory:                   product['inventory'],
                     instock:                     product['instock'],
                     desired_stock:               product['desired_stock'],
                     price:                       product['price'],
                     type_:                       product['type'],
                     alias:                       product['alias'],
                     keywords:                    product['keywords'],
                     src:                         product['src'])
    end
  end

  def updateProducts(categoryitem, products)
    products.each do |product|
      if p = Product.find_by(product_id: product['id'])
        p.update(rest_id:                     product['rest_id'],
                 categoryitem_id:             categoryitem.id,
                 restaurant_menu_categories:  product['restaurant_menu_categories'],
                 label:                       product['label'],
                 item_number:                 product['item_number'],
                 inventory:                   product['inventory'],
                 instock:                     product['instock'],
                 desired_stock:               product['desired_stock'],
                 price:                       product['price'],
                 type_:                       product['type'],
                 alias:                       product['alias'],
                 keywords:                    product['keywords'],
                 src:                         product['src'])
      end
    end
  end

end
