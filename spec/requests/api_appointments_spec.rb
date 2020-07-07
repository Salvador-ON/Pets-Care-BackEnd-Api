require 'rails_helper'

RSpec.describe 'test api appointments routes', type: :request do
  before(:all) do
    Service.create(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
  end

  it 'should return success if get /appointments is succesful ' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    appointments_before = Appointment.all.count
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/appointments', params: { appointment: { date: '2020-06-28',
                                                   time: '9:00',
                                                   service_id: '1',
                                                   pet_name: 'pipe' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    appointments_after = Appointment.all.count
    expect(appointments_before < appointments_after).to eq(true)
    get '/appointments'
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['appointments'][0]['service_name']).to eq('serv1')
  end

  it 'should return success if post /appointments is succesful ' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    appointments_before = Appointment.all.count
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/appointments', params: { appointment: { date: '2020-06-28',
                                                   time: '9:00',
                                                   service_id: '1',
                                                   pet_name: 'pipe' } }
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['status']).to eq('created')
    appointments_after = Appointment.all.count
    expect(appointments_before < appointments_after).to eq(true)
  end

  it 'should return success if delete /appointments is succesful ' do
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    appointments_before = Appointment.all.count
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/appointments', params: { appointment: { date: '2020-06-28',
                                                   time: '9:00',
                                                   service_id: '1',
                                                   pet_name: 'pipe' } }
    delete '/appointments/1'
    expect(response).to have_http_status(:success)
    appointments_after = Appointment.all.count
    expect(appointments_before == appointments_after).to eq(true)
  end

  it 'should return created if user create an appointment succesfully' do
    appointments_before = Appointment.all.count
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
    post '/appointments', params: { appointment: { date: '2020-06-28',
                                                   time: '9:00',
                                                   service_id: '1',
                                                   pet_name: 'pipe' } }
    expect(JSON.parse(response.body)['status']).to eq('created')
    appointments_after = Appointment.all.count
    expect(appointments_before < appointments_after).to eq(true)
  end

  it 'should return false if user create an appointment is logged out' do
    appointments_before = Appointment.all.count
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
    post '/appointments', params: { appointment: { date: '2020-06-28',
                                                   time: '9:00',
                                                   service_id: '1',
                                                   pet_name: 'pipe' } }
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
    appointments_after = Appointment.all.count
    expect(appointments_before == appointments_after).to eq(true)
  end
end
