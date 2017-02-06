class API::V1::CategoriesController < ApplicationController

  def index
    categories = Category.all
    data = categories.to_json(include: :subcategories, except: [:created_at, :updated_at])

    render_response(JSON(data), 'SUCCESS', '')
  end

  def show
    category = Category.find(params[:id])
    data = category.to_json(include: :subcategories, except: [:created_at, :updated_at])

    render_response(JSON(data), 'SUCCESS', '')
  end

end