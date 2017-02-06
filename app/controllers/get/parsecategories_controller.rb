class Get::ParsecategoriesController < ApplicationController

  def parse
    createCategories()

    renderCategories
  end

  def createCategories()
    if Category.all.count == 0
      Category.create(name: 'RESTAURANTS', position: 0)
      Category.create(name: 'SHOPS', position: 1)
    end
  end

  def renderCategories
    categories = Category.all

    render json: categories
  end

end
