class Api::V1::UsersController < ApplicationController

  def index
    users = User.all

    render_response(users, 'SUCCESS', '')
  end

  def show
    user = User.find(params[:id])
    product_ids = Favorite.where(user_id: params[:id], state: true).pluck(:product_id)
    products = Product.find(product_ids)
    data = {user: user, favorites: products}

    render_response(data, 'SUCCESS', '')
  end

  def create
    user = User.new
    if user.save
      render_response(user, 'SUCCESS', '')
    else
      render_response('', 'ERROR', '')
    end
  end

  def send_phone
    if user = User.find(params[:id])
      # mobile_number = params[:mobile_number]
      # if mobile_number[0] = "0"
      #   mobile_number.sub!("0", '+374')
      # end

      user.mobile_number = params[:mobile_number]
      user.verification_code =  1_000 + rand(10_000 - 1_000)
      user.save
    #
    # @twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
    # @twilio_client.account.sms.messages.create(
    #     :from => ENV['TWILIO_PHONE_NUMBER'],
    #     :to => to,
    #     :body => "Your verification code is #{user.verification_code}."
    # )

      render_response('', 'SUCCESS', 'A verification code has been sent to your mobile. Please fill it in below.')
    else
      render_response('', 'ERROR', 'Invalid user.')
    end
  end

  def verify
    if user = User.find_by(verification_code: params[:verification_code])
      user.is_verified = true
      user.verification_code = ''
      user.save
      data = {user: user}

      render_response(data, 'SUCCESS', 'Thank you for verifying your mobile number.')
    else
      render_response('', 'ERROR', 'Invalid verification code.')
    end
  end

end