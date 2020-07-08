require 'rails_helper'

RSpec.describe 'test api dashboard routes', type: :request do
  before(:each) do
    create_service
  end

  it 'should return success if get /dashboard is valid ' do
    create_admin_user
    sign_in_admin
    post_appointment
    get '/dashboard?date=2020-06-28'
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['data_appointments'][0]['service']).to eq('serv1')
  end

  it 'should return serv1 if user has admin role' do
    create_admin_user
    sign_in_admin
    get '/dashboard?date=2020-06-28'
    expect(JSON.parse(response.body)['data_appointments'][0]['service']).to eq('serv1')
  end

  it 'should return false if user is a client ' do
    create_client_user
    sign_in
    get '/dashboard?date=2020-06-28'
    expect(JSON.parse(response.body)['permission']).to eq(false)
  end

  it 'should return false if user is not logge id ' do
    get '/dashboard?date=2020-06-28'
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end
end
