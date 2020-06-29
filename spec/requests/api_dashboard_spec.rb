require 'rails_helper'

RSpec.describe 'test api dashboard routes', type: :request do
    
  it 'return success if get /dashboard is valid ' do
    get '/dashboard?date=2020-06-28'
    expect(response).to have_http_status(:success)
  end

  it 'returns serv1 if user has admin role' do
    User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 2) # rubocop:disable Layout/LineLength
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    Service.create(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    get '/dashboard?date=2020-06-28'
    expect(JSON.parse(response.body)['data_appointments'][0]['service']).to eq('serv1')
  end

  # it 'returns false if user is a client ' do
  #   User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
  #   post '/signin', params: { user: { email: 'ut1@ut1.com', password: '1234567' } }
  #   Service.create(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
  #   post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
  #   get '/dashboard?date=2020-06-28'
  #   expect(JSON.parse(response.body)['permission']).to eq(false)
  # end

  # it 'returns false if user is not logge id ' do
  #   Service.create(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
  #   get '/dashboard?date=2020-06-28'
  #   expect(JSON.parse(response.body)['logged_in']).to eq(false)
  # end
end
