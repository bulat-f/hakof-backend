# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create]
  before_action :find_user, except: %i[create index]
  before_action :check_self_or_admin, only: %i[update destroy]

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
      json = UserBlueprint.render @user, view: :auth
      render json: json, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    if @user.update(user_params)
      json = UserBlueprint.render @user, view: :extended
      render json: json, status: :ok
    else
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
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end

  def check_self_or_admin
    render(status: :forbidden) unless @user.id == current_user.id || current_user.admin?
  end
end
