require 'rails_helper'

RSpec.describe 'test api registration routes', type: :request do
  it 'should return success if post /signed_up is valid ' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: '' } }
    expect(response).to have_http_status(:success)
  end

  it 'should return true if user with user role is created propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: '' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'should return true if user with admin role is created propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['EMPLOYE_TOKEN'] } }
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'should return true if user with admin role has admin role saved propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['ADMIN_TOKEN'] } }
    expect(JSON.parse(response.body)['user']['role']).to eq('admin')
  end

  it 'should return employe if user role was saved propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['EMPLOYE_TOKEN'] } }
    expect(JSON.parse(response.body)['user']['role']).to eq('employe')
  end

  it 'should not  returns admin if user role was saved propperly' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['EMPLOYE_TOKEN'] } }
    expect(JSON.parse(response.body)['user']['role']).not_to eq('admin')
  end

  it 'should return invalid-token if user was created with incorect token' do
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: 'invalid-token' } }
    expect(JSON.parse(response.body)['token']).to eq('false')
  end
end
