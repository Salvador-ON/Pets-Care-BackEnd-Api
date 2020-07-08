require 'rails_helper'

RSpec.describe 'test api availables routes', type: :request do
  before(:each) do
    create_service
  end

  it 'should return success if get /dashboard is valid ' do
    get '/availables?service_id=1&date=2020-06-28'
    expect(response).to have_http_status(:success)
  end

  it 'should return true if appointment is avilable' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    get '/availables?service_id=1&date=2020-07-27'
    expect(JSON.parse(response.body)['appointments'][0]).to eq('9:00')
  end

  it 'should return false if user is a client is not logged ' do
    get '/availables?service_id=1&date=2020-07-27'
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end
end
