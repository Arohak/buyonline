class API::V1::FavoritesController < ApplicationController

  def index
    if params[:user_id]
      favorite_ids = Favorite.where(user_id: params[:user_id]).ids
      products = Product.find(favorite_ids)

      render_response(products, 'SUCCESS', '')
    elsif
      render_response(products, 'ERROR', 'parameter invalid')
    end
  end

  def update
    if params[:user_id]
      favorite = Favorite.find_by(user_id: params[:user_id], product_id: params[:id])

      if favorite
        favorite.update(state: !favorite.state)
      else
        Favorite.create(user_id: params[:user_id], product_id: params[:id], state: true)
      end

      render_response('', 'SUCCESS', '')
    elsif
      render_response(products, 'ERROR', 'parameter invalid')
    end
  end

end