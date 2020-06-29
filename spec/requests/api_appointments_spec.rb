require 'rails_helper'

RSpec.describe 'test api appointments routes', type: :request do
  before(:all) do
    Service.create(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
  end

  it 'should return success if get /appointments is valid ' do
    get '/appointments'
    expect(response).to have_http_status(:success)
  end

  it 'should return success if post /appointments is valid ' do
    post '/appointments'
    expect(response).to have_http_status(:success)
  end

  it 'should return success if delete /appointments is valid ' do
    delete '/appointments/1'
    expect(response).to have_http_status(:success)
  end

  it 'should return created if user create an appointment succesfully' do
    User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/appointments', params: { appointment: { date: '2020-06-28', time: '9:00', service_id: '1', pet_name: 'pipe' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'should return false if user create an appointment is logged out' do
    User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    post '/appointments', params: { appointment: { date: '2020-06-28', time: '9:00', service_id: '1', pet_name: 'pipe' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end
end
