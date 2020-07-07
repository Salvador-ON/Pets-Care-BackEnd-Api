require 'rails_helper'

RSpec.describe 'test api registration routes', type: :request do
  it 'should return success if post /signed_up is valid ' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: '' } }
    expect(response).to have_http_status(:success)
    user_after = User.all.count
    expect(user_before < user_after).to eq(true)
  end

  it 'should return true if user with user role is created propperly' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: '' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    user_after = User.all.count
    expect(user_before < user_after).to eq(true)
    expect(User.last.role).to eq('user')
  end

  it 'should return true if user with employe role is created propperly' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['EMPLOYE_TOKEN'] } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    user_after = User.all.count
    expect(user_before < user_after).to eq(true)
    expect(User.last.role).to eq('employe')
  end

  it 'should return true if user with admin role has admin role saved propperly' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['ADMIN_TOKEN'] } }
    expect(JSON.parse(response.body)['user']['role']).to eq('admin')
    user_after = User.all.count
    expect(user_before < user_after).to eq(true)
    expect(User.last.role).to eq('admin')
  end

  it 'should return employe if user role was saved propperly' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['EMPLOYE_TOKEN'] } }
    expect(JSON.parse(response.body)['user']['role']).to eq('employe')
    user_after = User.all.count
    expect(user_before < user_after).to eq(true)
    expect(User.last.role).to eq('employe')
  end

  it 'should not  returns admin if user role was saved propperly' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: ENV['EMPLOYE_TOKEN'] } }
    expect(JSON.parse(response.body)['user']['role']).not_to eq('admin')
    user_after = User.all.count
    expect(user_before < user_after).to eq(true)
    expect(User.last.role).not_to eq('admin')
  end

  it 'should return invalid-token if user was created with incorect token' do
    user_before = User.all.count
    post '/signup', params: { user: { email: 'ut1@ut1.com',
                                      name: 'user test 1',
                                      phone: '123456789',
                                      password: '123456',
                                      password_confirmation: '123456',
                                      token: 'invalid-token' } }
    expect(JSON.parse(response.body)['token']).to eq('false')
    user_after = User.all.count
    expect(user_before == user_after).to eq(true)
  end
end
