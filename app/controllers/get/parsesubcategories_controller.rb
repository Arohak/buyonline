require 'open-uri'

class Get::ParsesubcategoriesController < ApplicationController

  def parse
    url = $ROOT_URL + GET_ALL + "?lng=#{params[:lng]}"
    response  = RestClient.get url
    response = getCorrectText(response)
    json = JSON.parse(response)

    subcategories  = json['categories']
    restaurants    = json['restaurants']
    shops          = json['shops']

    parseSubcategories(subcategories)
    parseRestaurants(restaurants.first(11))
    # parseShops(shops.first(20))
    # parseShopsInRestaurants()
    # hasManySubcategoriesRestaurants(subcategories, restaurants)

    render text: 'OK'
  end

  def getCorrectText(text)
    s = 22
    e = text.mb_chars.length - 1
    str = text[s...e]

    return str
  end

  def parseSubcategories(subcategories)
    if Subcategory.all.count > 0
      subcategories.each do |subcategory|
        cat = Subcategory.find_by(subcategory_id:  subcategory['id'])
        category_id = subcategory['type'] == 'restaurants' ? 1 : 2

        # dowloadImageWith(subcategory['src'])

        cat.update(category_id:     category_id,
                   name:        subcategory['label'],
                   title:       subcategory['title'],
                   position:    subcategory['position'],
                   src:         subcategory['src'])
      end
    else
      subcategories.each do |subcategory|
        category_id = subcategory['type'] == 'restaurants' ? 1 : 2

        Subcategory.create(category_id:     category_id,
                           subcategory_id:  subcategory['id'],
                           name:            subcategory['label'],
                           title:           subcategory['title'],
                           position:        subcategory['position'],
                           src:             subcategory['src'])
      end
    end

  end

  def dowloadImageWith(url)
    local_path = "img/categories/#{url.to_s.split('/')[-1]}"
    open(local_path, 'wb') do |file|
      file << open(url).read
    end
  end

  def parseRestaurants(restaurants)
    if Restaurant.all.count > 0
      restaurants.each do |restaurant|
        res = Restaurant.find_by(restaurant_id:  restaurant['id'])
          if res
            res.update(restaurant_id:    restaurant['id'],
                       label:            restaurant['label'],
                       description:      restaurant['description'],
                       hash_:            restaurant['hash'],
                       status:           restaurant['status'],
                       position:         restaurant['position'],
                       budget:           restaurant['budget'],
                       openTime:         restaurant['openTime'],
                       closeTime:        restaurant['closeTime'],
                       src:              restaurant['src'],
                       min_amount_order: restaurant['min_amount_order'],
                       rate:             restaurant['rate'],
                       totalHours:       restaurant['totalHours'],
                       around:           restaurant['around'],
                       new:              restaurant['new'])
            end
      end
    else
      restaurants.each do |restaurant|
        Restaurant.create(restaurant_id:    restaurant['id'],
                          label:            restaurant['label'],
                          description:      restaurant['description'],
                          hash_:            restaurant['hash'],
                          status:           restaurant['status'],
                          position:         restaurant['position'],
                          budget:           restaurant['budget'],
                          openTime:         restaurant['openTime'],
                          closeTime:        restaurant['closeTime'],
                          src:              restaurant['src'],
                          min_amount_order: restaurant['min_amount_order'],
                          rate:             restaurant['rate'],
                          totalHours:       restaurant['totalHours'],
                          around:           restaurant['around'],
                          new:              restaurant['new'])
      end
    end

  end

  def parseShops(shops)
    if Shop.all.count > 0
      shops.each do |shop|
        s = Shop.find_by(shop_id:  shop['id'])
        if s
          s.update(shop_id:          shop['id'],
                   label:            shop['label'],
                   description:      shop['description'],
                   hash_:            shop['hash'],
                   status:           shop['status'],
                   position:         shop['position'],
                   budget:           shop['budget'],
                   openTime:         shop['openTime'],
                   closeTime:        shop['closeTime'],
                   src:              shop['src'],
                   min_amount_order: shop['min_amount_order'],
                   rate:             shop['rate'],
                   totalHours:       shop['totalHours'],
                   around:           shop['around'],
                   new:              shop['new'])
        end
      end
    else
      shops.each do |shop|
        Shop.create(shop_id:          shop['id'],
                    label:            shop['label'],
                    description:      shop['description'],
                    hash_:            shop['hash'],
                    status:           shop['status'],
                    position:         shop['position'],
                    budget:           shop['budget'],
                    openTime:         shop['openTime'],
                    closeTime:        shop['closeTime'],
                    src:              shop['src'],
                    min_amount_order: shop['min_amount_order'],
                    rate:             shop['rate'],
                    totalHours:       shop['totalHours'],
                    around:           shop['around'],
                    new:              shop['new'])
      end
    end

  end

  def parseShopsInRestaurants()
      Shop.all.each do |shop|
        r = Restaurant.find_by(restaurant_id:  shop.shop_id)
        if r.nil?
          Restaurant.create(restaurant_id:    shop.shop_id,
                            label:            shop.label,
                            description:      shop.description,
                            hash_:            shop.hash_,
                            status:           shop.status,
                            position:         shop.position,
                            budget:           shop.budget,
                            openTime:         shop.openTime,
                            closeTime:        shop.closeTime,
                            src:              shop.src,
                            min_amount_order: shop.min_amount_order,
                            rate:             shop.rate,
                            totalHours:       shop.totalHours,
                            around:           shop.around,
                            new:              shop.new)
        end
      end
    end

  def hasManySubcategoriesRestaurants(subcategories, restaurants)
    subcategories.each_with_index do |subcategory, index|
      cat = Subcategory.find_by(subcategory_id: subcategory['id'])
      cat.restaurants.clear
      subcategory['restaurants'].each do |id|
        if restaurant = Restaurant.find_by(restaurant_id: id)
          cat.restaurants << restaurant
        elsif shop = Shop.find_by(shop_id: id)
          cat.restaurants << shop
        end
      end
    end

    restaurants.each do |restaurant|
      res = Restaurant.find_by(restaurant_id: restaurant['id'])
      res.subcategories.clear
      restaurant['categories'].each do |id|
        if subcategory = Subcategory.find_by(subcategory_id: id)
          res.subcategories << subcategory
        end
      end
    end
  end


  def renderSubcategories
    subcategories = Subcategory.all

    render json: subcategories
  end

  def renderRestaurants
    restaurants = Restaurant.all

    render json: restaurants
  end

  def renderSubcategoryRestaurants
    subcategories = Subcategory.all

    render json: subcategories.first.restaurants
  end

  def renderRestaurantSubcategories
    restaurants = Restaurant.all

    render json: restaurants.first.subcategories
  end

  def deleteObjects
    Restaurant.delete_all
    Category.delete_all
  end

end
