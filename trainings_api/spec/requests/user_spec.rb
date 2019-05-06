require 'rails_helper'

describe 'POST /users' do
  let(:url) { '/users' }
  let!(:user) { create_list(:user, 10) }
  let(:pw) { Faker::Internet.password }
  let(:valid_data) do
    {
        email: Faker::Internet.email,
        username: Faker::Internet.user_name ,
        name: Faker::Name.name,
        password: pw,
        password_confirm: pw
    }
  end
  let(:invalid_data) do
    {
        email: user.first.email,
        username: user.first.username,
        name: Faker::Name.name,
        password: "short",
        password_confirm: "pw"
    }
  end


  context 'when creating a new user with valid data' do
    before { post url, params: valid_data  }

    it 'returns 201' do
      expect(response).to have_http_status(201)
    end

    it 'returns new user data' do
      expect(json['username']).not_to be_empty
      expect(json['email']).not_to be_empty
      expect(json['name']).not_to be_empty
    end
  end

  context 'When user already exists' do
    before { post url, params: invalid_data }

    it 'returns 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns taken user error' do
      expect(json['errors']).to include('Username has already been taken')
    end
  end

  context 'When email already exists' do
    before { post url, params: invalid_data }

    it 'returns 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns taken user error' do
      expect(json['errors']).to include('Email has already been taken')
    end
  end

  context 'When password is too short' do
    before { post url, params: invalid_data }

    it 'returns 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns taken user error' do
      expect(json['errors']).to include('Password is too short (minimum is 6 characters)')
    end
  end

end

describe 'GET /users' do
  let(:url) { '/users' }
  let!(:user) { create_list(:user, 1) }

  context 'when fetching all users data' do
    before { get url, params: {}, headers: authenticated_header(user.first)  }

    it 'returns 200' do
      expect(response).to have_http_status 200
    end

    it 'returns array of users' do
      expect(json).not_to be_empty
    end
  end

end

describe 'GET /users/{username}' do
  let!(:user) { create_list(:user, 10) }
  let(:url) { "/users/#{user.last.username}" }

  context 'when fetching an existing specific user data' do
    before { get url, params: {}, headers: authenticated_header(user.first) }

    it 'returns 200' do
      expect(response).to have_http_status 200
    end

    it 'returns a user data' do
      expect(json).not_to be_empty
    end
  end

  context 'User does not exist' do
    before { get "/users/jon_snow", params: {}, headers: authenticated_header(user.first) }

    it 'returns 404' do
      expect(response).to have_http_status 404
    end

  end
end

def authenticated_header(user)
  token = JsonWebToken.encode(user_id: user.id)
  { "Authorization" => token }
end
