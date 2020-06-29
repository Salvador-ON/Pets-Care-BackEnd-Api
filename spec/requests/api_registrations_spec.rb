require 'rails_helper'

RSpec.describe 'test api registration routes', type: :request do
  it 'return success if post /signed_up is valid ' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: '' } } # rubocop:disable Layout/LineLength
    expect(response).to have_http_status(:success)
  end

  it 'returns true if user with user role is created propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: '' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'returns true if user with admin role is created propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: ENV['EMPLOYE_TOKEN'] } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'returns true if user with admin role has admin role saved propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: ENV['ADMIN_TOKEN'] } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['user']['role']).to eq('admin')
  end

  it 'user role returns employe if user role was saved propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: ENV['EMPLOYE_TOKEN'] } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['user']['role']).to eq('employe')
  end

  it 'user role shoudl not returns admin if user role was saved propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: ENV['EMPLOYE_TOKEN'] } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['user']['role']).not_to eq('admin')
  end

  it 'returns invalid-token if user  was created with incorecct token' do
    post '/signup', params: { user: { email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', token: 'invalid-token' } } # rubocop:disable Layout/LineLength
    expect(JSON.parse(response.body)['error']).to eq('invalid-token')
  end
end
