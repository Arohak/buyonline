class Get::ParsemenuController < ApplicationController

  def parse
    Restaurant.all.each do |r|
      url = $ROOT_URL + GET_CATEGORY_ITEMS + r.restaurant_id.to_s + "&lng=#{params[:lng]}"
      response  = RestClient.get url
      response = getCorrectText(response)
      json = JSON.parse(response)
      categories  = json['categories']

      parseCategoryitems(r, categories)
    end

    render text: 'OK'
  end

  def translation
    Restaurant.all.each do |r|
      url = $ROOT_URL + GET_CATEGORY_ITEMS + r.restaurant_id.to_s + "&lng=#{params[:lng]}"
      response  = RestClient.get url
      response = getCorrectText(response)
      json = JSON.parse(response)
      categories  = json['categories']

      updateCategoryitems(r, categories)
    end

    render text: 'OK'
  end

  def getCorrectText(text)
    s = 22
    e = text.mb_chars.length - 1
    str = text[s...e]

    return str
  end

  def parseCategoryitems(restaurant, categoryitems)
    categoryitems.each do |categoryitem|
      Categoryitem.create(categoryitem_id:  categoryitem['id'],
                          rest_id:          categoryitem['restaurant_menu_categories'],
                          restaurant_id:    restaurant.id,
                          name:             categoryitem['label'])
    end
  end

  def updateCategoryitems(restaurant, categoryitems)
    categoryitems.each do |categoryitem|
      if c = Categoryitem.find_by(categoryitem_id: categoryitem['id'])
        c.update(rest_id:          categoryitem['restaurant_menu_categories'],
                 restaurant_id:    restaurant.id,
                 name:             categoryitem['label'])
      end
    end
  end

end
