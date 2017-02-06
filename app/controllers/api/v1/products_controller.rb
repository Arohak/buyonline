class API::V1::ProductsController < ApplicationController

  def index
    l       = params[:limit]
    o       = params[:offset]

    if params[:categoryitem_id]
      @products = Product.where(categoryitem_id: params[:categoryitem_id]).limit(l).offset(o)
    elsif params[:search]
      @products = Product.search(params[:search]).limit(l).offset(o)
    elsif params[:user_id]
      product_ids = Favorite.where(user_id: params[:user_id], state: true).limit(l).offset(o).pluck(:product_id)
      @products = Product.find(product_ids)
    else
      @products = Product.all.limit(l).offset(o)
    end

    render_response(@products, 'SUCCESS', '')
  end

  def show

  end

end