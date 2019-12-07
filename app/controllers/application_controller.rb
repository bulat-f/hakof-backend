# frozen_string_literal: true

class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }, status: :not_found
  end

  def authorize_request
    render(status: :unauthorized) unless current_user
  end

  def check_admin
    render(status: :forbidden) unless current_user&.admin?
  end

  def current_user
    return @current_user if @current_user

    begin
      @decoded = JsonWebToken.decode(auth_token)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      nil
    rescue JWT::DecodeError => e
      nil
    end
  end

  def auth_token
    return @auth_token if @auth_token

    header = request.headers['Authorization']
    @auth_token = header.split(' ').last if header
  end
end
