require 'rails_helper'

RSpec.describe 'test api sessions routes', type: :request do
  it 'return success if get /logged_in is valid ' do
    get '/logged_in'
    expect(response).to have_http_status(:success)
  end

  it 'return success if delete /logout is valid ' do
    delete '/logout'
    expect(response).to have_http_status(:success)
  end

  it 'returns false if user is not logged_in' do
    get '/logged_in'
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end

  it 'returns true if user is logged_in' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    expect(JSON.parse(response.body)['logged_in']).to eq(true)
  end

  it 'returns false if user not logged_in correct' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '1234567' } }
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end

  it 'returns true if user logged_out correct' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    expect(JSON.parse(response.body)['logged_in']).to eq(true)
    delete '/logout'
    expect(JSON.parse(response.body)['logged_out']).to eq(true)
  end
end
