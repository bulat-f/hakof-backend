# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # POST /auth/login
  def login
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(login_params[:password])
      json = UserBlueprint.render(@user, view: :auth)
      render json: json, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
