require 'rails_helper'

RSpec.describe 'test api services routes', type: :request do
  it 'should return success if get /services is valid ' do
    get '/services'
    expect(response).to have_http_status(:success)
  end

  it 'should return success if post /services is valid ' do
    post '/services'
    expect(response).to have_http_status(:success)
  end

  it 'should return success if delete /services is valid ' do
    delete '/services/1'
    expect(response).to have_http_status(:success)
  end

  it 'should return created if admin create a service succesfully' do
    User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 2) # rubocop:disable Layout/LineLength
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'should return not_created if admin try to create a service with missing information' do
    User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 2) # rubocop:disable Layout/LineLength
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['status']).to eq('not_created')
  end

  it 'should return false if admin try to create an appointment  logged out' do
    post '/services', params: { service: { name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end
end
