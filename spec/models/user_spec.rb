require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should return true if user is saved' do
    u1 = User.new(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(true)
    expect(u1.save).to eq(true)
  end

  it 'should return false if user has empty name' do
    u1 = User.new(email: 'ut1@ut1.com', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end

  it 'should return false if user existed' do
    User.create(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    u1 = User.new(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end

  it 'should return false if user has empty phone' do
    u1 = User.new(email: 'ut1@ut1.com', name: 'user test 1', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end

  it 'should return false if user has empty email' do
    u1 = User.new(name: 'user test 1', phone: '123456789', password: '123456', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end

  it 'should return false if user has empty password' do
    u1 = User.new(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end

  it 'should return false if user has empty password_Confirmation' do
    u1 = User.new(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end

  it 'should return false if passwords dont macth' do
    u1 = User.new(email: 'ut1@ut1.com', name: 'user test 1', phone: '123456789', password: '12345678', password_confirmation: '123456', role: 0) # rubocop:disable Layout/LineLength
    expect(u1.valid?).to eq(false)
  end
end
