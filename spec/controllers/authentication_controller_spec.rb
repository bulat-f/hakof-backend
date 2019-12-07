# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController do
  describe '#login' do
    let(:password) { 'password1' }
    let!(:user) do
      create :user, password: password, password_confirmation: password
    end

    it 'returns token when everything is right' do
      post :login, params: { email: user.email, password: password }
      expect(response).to have_http_status(:ok)
    end

    it 'does not return token when password is incorrect' do
      post :login, params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
