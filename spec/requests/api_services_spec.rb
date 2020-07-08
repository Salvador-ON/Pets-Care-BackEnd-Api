require 'rails_helper'

RSpec.describe 'test api services routes', type: :request do
  it 'should return success if get /services is succesfully got' do
    create_admin_user
    sign_in_admin
    expect { post_service }.to change { Service.count }.by(1)
    expect(JSON.parse(response.body)['status']).to eq('created')
    get '/services'
    expect(JSON.parse(response.body)['services'].last['name']).to eq('serv22')
    expect(response).to have_http_status(:success)
  end

  it 'should return success if post /services is succesfully created' do
    create_admin_user
    sign_in_admin
    expect { post_service }.to change { Service.count }.by(1)
    expect(JSON.parse(response.body)['status']).to eq('created')
    expect(response).to have_http_status(:success)
  end

  it 'should return success if delete /services is succesfully deleted' do
    create_admin_user
    sign_in_admin
    expect { post_service }.to change { Service.count }.by(1)
    expect(JSON.parse(response.body)['status']).to eq('created')
    expect { delete '/services/1' }.to change { Service.count }.by(-1)
    expect(response).to have_http_status(:success)
  end

  it 'should return not created if employe created a service' do
    create_client_user
    sign_in
    expect { post_service }.to change { Service.count }.by(0)                                     
    expect(JSON.parse(response.body)['permission']).to eq(false)
  end

  it 'should return not_created if admin try to create a service with missing information' do
    create_admin_user
    sign_in_admin
    expect { post_invalid_service }.to change { Service.count }.by(0)  
    expect(JSON.parse(response.body)['status']).to eq('not_created')
  end

  it 'should return false if user try to create a services logged out' do
    expect { post_service }.to change { Service.count }.by(0) 
    expect(JSON.parse(response.body)['logged_in']).to eq(false)
  end
end
