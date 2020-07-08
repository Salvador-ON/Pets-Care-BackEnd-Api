require 'rails_helper'

RSpec.describe 'test api registration routes', type: :request do
  it 'should return success if post /signed_up is valid ' do
    expect { sign_up_user }.to change { User.count }.by(1)       
    expect(response).to have_http_status(:success)
  end

  it 'should return true if user with user role is created propperly' do
    user_before = User.all.count
    expect { sign_up_user }.to change { User.count }.by(1)   
    expect(JSON.parse(response.body)['status']).to eq('created')
    expect(User.last.role).to eq('user')
  end

  it 'should return true if user with employe role is created propperly' do
    expect { sign_up_employe }.to change { User.count }.by(1)   
    expect(JSON.parse(response.body)['status']).to eq('created')
    expect(User.last.role).to eq('employe')
  end

  it 'should return true if user with admin role has admin role saved propperly' do
    expect { sign_up_admin }.to change { User.count }.by(1)                          
    expect(JSON.parse(response.body)['user']['role']).to eq('admin')
    expect(User.last.role).to eq('admin')
  end

 

  it 'should not returns admin if user role was saved propperly' do
    expect { sign_up_employe }.to change { User.count }.by(1)
    expect(JSON.parse(response.body)['user']['role']).not_to eq('admin')
    expect(User.last.role).not_to eq('admin')
  end

  it 'should return invalid-token if user was created with incorect token' do
    expect { sign_up_invalid_token }.to change { User.count }.by(0)
    expect(JSON.parse(response.body)['token']).to eq('false')
  end
end
