require 'rails_helper'

describe 'POST /auth/login' do
  let(:url) { '/auth/login' }
  let!(:user) { create_list(:user, 10) }
  let(:valid_params) do
    {
        'email' => user.first.email.to_s,
        'password' => user.first.password.to_s
    }
  end

  context 'When user sends valid data' do
    before { post url, params: valid_params }

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a username' do
        expect(json['username']).not_to be_empty
      end

      it 'returns a token' do
        expect(json['token']).not_to be_empty
      end
  end

  context 'When user sends wrong username' do
    before { post url, params: { email: user.first.email << 'pla', password: user.first.password << 'plo'} }

    it 'returns status 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns an email not found message' do
      expect(json['error']).to match(/Email address not found/)
    end
  end

  context 'When user sends wrong password' do
    before { post url, params: { email: user.first.email, password: user.first.password << 'plo'} }

    it 'returns status 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns a wrong password message' do
      expect(json['error']).to match(/Wrong password/)
    end
  end
end