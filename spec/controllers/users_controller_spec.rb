# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe '#create' do
    it 'creates user with correct data' do
      user_attributes = build(:user).attributes
      params = user_attributes.merge(
        password: 'password1', password_confirmation: 'password1'
      )
      post :create, params: params
      expect(response).to have_http_status(:created)
    end

    it 'does not create user when password cofirmation doesn\'t match' do
      user_attributes = build(:user).attributes
      params = user_attributes.merge(
        password: 'password1', password_confirmation: 'password2'
      )
      post :create, params: params

      expect(response).not_to have_http_status(:created)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create user when email is used already' do
      user_attributes = create(:user).attributes
      params = user_attributes.merge(
        password: 'password1', password_confirmation: 'password1'
      )
      post :create, params: params

      expect(response).not_to have_http_status(:created)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
