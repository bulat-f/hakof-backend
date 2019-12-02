# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create]
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    json = UserBlueprint.render User.all, view: :normal
    render json: json, status: :ok
  end

  # GET /users/{id}
  def show
    json = UserBlueprint.render @user, view: :extended
    render json: json, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      json = UserBlueprint.render @user, view: :extended
      render json: json, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
    puts "User with id #{params[:id]}"
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
