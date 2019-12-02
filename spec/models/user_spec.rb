# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#token' do
    it 'returns a string' do
      user = build(:user)

      expect(user.token.class).to eq(String)
    end

    it 'caches token' do
      user = build(:user)
      expeced = user.token

      expect(user.token).to eq(expeced)
    end

    it 'defines `@token_expiration`' do
      user = build(:user)

      expect(user.token_expiration).to be_blank
      user.token
      expect(user.token_expiration).to be_present
    end
  end
end
