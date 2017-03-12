class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :set_locale
  skip_before_action :verify_authenticity_token


  # 1. Armenia  lng=3,  locale=hy
  # 2. Russia   lng=6,  locale=ru
  # 3. English  lng=7,  locale=eu

  # http://api.menu.am/index.php/index
  # http://api.menu.am/index.php/index/delivery-price?lng=3
  # http://api.menu.am/index.php/index/get-data?lng=6
  # http://api.menu.am/index.php/index/get-restaurant-menu-categories?rest=290&lng=6
  # http://api.menu.am/index.php/index/get-restaurant-menu?rest=290&restaurant_menu_categories=1291&lng=7


  $ROOT_URL             = 'http://api.menu.am/index.php/index/'
  GET_DELIVERY          = 'delivery-price'
  GET_ALL               = 'get-data'
  GET_CATEGORY_ITEMS    = 'get-restaurant-menu-categories?rest='

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
    elsif request.headers['locale']
      I18n.locale = request.headers['locale']
    end
  end

  def render_response(data, status, message)
    response = { data:    data,
                 result:  {status: status,
                           message: message} }

    render json: response
  end
end
