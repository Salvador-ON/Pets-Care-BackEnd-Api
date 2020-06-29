require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it 'should return true if service can be created' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(date: '2020-06-28', time: '9:00', service_id: '1', pet_name: 'pipe', user_id: '1')
    expect(a1.valid?).to eq(true)
  end

  it 'should return false if name is empty' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(date: '2020-06-28', time: '9:00', service_id: '1', pet_name: 'pipe', user_id: '1')
    expect(a1.valid?).to eq(true)
  end

  it 'should return false if time is empty' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(date: '2020-06-28', service_id: '1', pet_name: 'pipe', user_id: '1')
    expect(a1.valid?).to eq(false)
  end

  it 'should return false if date is empty' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(time: '9:00', service_id: '1', pet_name: 'pipe', user_id: '1')
    expect(a1.valid?).to eq(false)
  end

  it 'should return false if service_id is empty' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(date: '2020-06-28', time: '9:00', pet_name: 'pipe', user_id: '1')
    expect(a1.valid?).to eq(false)
  end

  it 'should return false if pet_name is empty' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(date: '2020-06-28', time: '9:00', service_id: '1', user_id: '1')
    expect(a1.valid?).to eq(false)
  end

  it 'should return false if user_id is empty' do
    User.create(email: 'ut22@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    Service.create(name: 'serv2', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    a1 = Appointment.new(date: '2020-06-28', time: '9:00', service_id: '1', pet_name: 'pipe')
    expect(a1.valid?).to eq(false)
  end
end
