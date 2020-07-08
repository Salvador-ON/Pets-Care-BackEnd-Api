require 'rails_helper'

RSpec.describe 'test api appointments routes', type: :request do
  before(:each) do
    create_service
    create_client_user
    sign_in
  end

  it 'should return success if get /appointments is succesfully retrieve ' do
    appointments_before = Appointment.all.count
    expect{post_appointment}.to change { Appointment.count }.by(1)
    expect(JSON.parse(response.body)['status']).to eq('created')
    get '/appointments'
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['appointments'][0]['service_name']).to eq('serv1')
  end

  it 'should return success if post /appointments is succesfully created ' do
    expect{post_appointment}.to change { Appointment.count }.by(1)
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)['status']).to eq('created')
  end

  it 'should return success if delete /appointments is succesful ' do
    post_appointment
    expect{delete '/appointments/1'}.to change { Appointment.count }.by(-1)
    expect(response).to have_http_status(:success)
  end

  it 'should return false if user create an appointment is logged out' do
    log_out
    expect{post_appointment}.to change { Appointment.count }.by(0)
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end
end
