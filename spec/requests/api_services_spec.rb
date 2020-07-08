require 'rails_helper'

RSpec.describe 'test api services routes', type: :request do
  it 'should return success if get /services is succesfull' do
    service_before = Service.all.count
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 2)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv22',
                                           price: '15',
                                           description: 'test',
                                           image_url: 'www.image.com',
                                           schedule: '9:00,10:00' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    service_after = Service.all.count
    expect(service_before < service_after).to eq(true)
    get '/services'
    expect(JSON.parse(response.body)['services'].last['name']).to eq('serv22')
    expect(response).to have_http_status(:success)
  end

  it 'should return success if post /services is succesfully' do
    service_before = Service.all.count
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 2)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv22',
                                           price: '15',
                                           description: 'test',
                                           image_url: 'www.image.com',
                                           schedule: '9:00,10:00' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    service_after = Service.all.count
    expect(service_before < service_after).to eq(true)
    expect(response).to have_http_status(:success)
  end

  it 'should return success if delete /services is succesfully' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 2)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv22',
                                           price: '15',
                                           description: 'test',
                                           image_url: 'www.image.com',
                                           schedule: '9:00,10:00' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    expect { delete '/services/1' }.to change { Service.count }.by(-1)
    expect(response).to have_http_status(:success)
  end

  it 'should return created if admin create a service succesfully' do
    service_before = Service.all.count
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 2)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv22',
                                           price: '15',
                                           description: 'test',
                                           image_url: 'www.image.com',
                                           schedule: '9:00,10:00' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    service_after = Service.all.count
    expect(service_before < service_after).to eq(true)
  end

  it 'should return not_created if admin try to create a service with missing information' do
    service_before = Service.all.count
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 2)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/services', params: { service: { name: 'serv1',
                                           price: '15',
                                           description: 'test',
                                           image_url: 'www.image.com' } }
    expect(JSON.parse(response.body)['status']).to eq('not_created')
    service_after = Service.all.count
    expect(service_before == service_after).to eq(true)
  end

  it 'should return false if user try to create an appointment logged out' do
    service_before = Service.all.count
    post '/services', params: { service: { name: 'serv1',
                                           price: '15',
                                           description: 'test',
                                           image_url: 'www.image.com',
                                           schedule: '9:00,10:00' } }
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
    service_after = Service.all.count
    expect(service_before == service_after).to eq(true)
  end
end
