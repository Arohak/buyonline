class API::V1::SubcategoriesController < ApplicationController

  def index
    subcategories = Subcategory.where(category_id: params[:category_id])

    render_response(subcategories, 'SUCCESS', '')
  end

  def show
    restaurants = Subcategory.find(params[:id]).restaurants.limit(params[:limit]).offset(params[:offset])
    data = restaurants.to_json(include: [:categoryitems, :addresses])

    render_response(JSON(data), 'SUCCESS', '')
  end

end