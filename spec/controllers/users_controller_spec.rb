# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe '#show' do
    let(:user) { create :user, first_name: 'Ross', last_name: 'G' }
    it 'does not show entity for not authorized users' do
      get :show, params: { id: user.id }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'shows entity for not autherized users' do
      request.headers.merge! Authorization: user.token
      get :show, params: { id: user.id }

      expected_body_part = { 'first_name' => 'Ross', 'last_name' => 'G' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include(expected_body_part)
    end
  end

  describe '#create' do
    let(:params) do
      build(:user).attributes.merge(
        password: 'password1', password_confirmation: 'password1'
      )
    end

    it 'creates user with correct data' do
      post :create, params: params
      expect(response).to have_http_status(:created)
    end

    it 'does not create user when password cofirmation doesn\'t match' do
      post :create, params: params.merge(password: 'not_match_with_confirm')
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not create user when email is used already' do
      create :user, params
      post :create, params: params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#update' do
    let(:user) { create :user, first_name: 'Ross', last_name: 'G' }
    let(:other_user) { create :user, first_name: 'Joey', last_name: 'T' }
    let(:params) { { id: user.id, last_name: 'Geller' } }

    it 'does not update when user is not authorized' do
      put :update, params: params
      expect(response).to have_http_status(:unauthorized)
    end

    it 'does not update other user (not admin)' do
      request.headers.merge! Authorization: other_user.token
      put :update, params: params
      expect(response).to have_http_status(:forbidden)
    end

    it 'updates authorized user' do
      request.headers.merge! Authorization: user.token
      put :update, params: params
      expected_body_part = { 'first_name' => 'Ross', 'last_name' => 'Geller' }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include(expected_body_part)
    end

    it 'updates all entities when user is admin' do
      admin = create :admin
      request.headers.merge! Authorization: admin.token
      put :update, params: params
      expected_body_part = { 'first_name' => 'Ross', 'last_name' => 'Geller' }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include(expected_body_part)
    end
  end

  describe '#destory' do
    let(:user) { create :user, first_name: 'Ross', last_name: 'G' }
    let(:other_user) { create :user, first_name: 'Joey', last_name: 'T' }
    let(:params) { { id: user.id } }

    it 'does not update when user is not authorized' do
      delete :destroy, params: params
      expect(response).to have_http_status(:unauthorized)
    end

    it 'does not update other user (not admin)' do
      request.headers.merge! Authorization: other_user.token
      delete :destroy, params: params
      expect(response).to have_http_status(:forbidden)
    end

    it 'updates authorized user' do
      request.headers.merge! Authorization: user.token
      delete :destroy, params: params

      expect(response).to have_http_status(:no_content)
    end

    it 'updates all entities when user is admin' do
      admin = create :admin
      request.headers.merge! Authorization: admin.token
      delete :destroy, params: params

      expect(response).to have_http_status(:no_content)
    end
  end
end
