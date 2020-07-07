require 'rails_helper'

RSpec.describe Service, type: :model do
  it 'should return true if service can be created' do
    s1 = Service.new(name: 'serv1',
                     price: '15',
                     description: 'test',
                     image_url: 'www.image.com',
                     schedule: '9:00,10:00')
    expect(s1.valid?).to eq(true)
  end

  it 'should return false if service already exist' do
    Service.create(name: 'serv2',
                   price: '15',
                   description: 'test',
                   image_url: 'www.image.com',
                   schedule: '9:00,10:00')
    s1 = Service.new(name: 'serv2',
                     price: '15',
                     description: 'test',
                     image_url: 'www.image.com',
                     schedule: '9:00,10:00')
    expect(s1.valid?).to eq(false)
  end

  it 'should return false if price is empty' do
    s1 = Service.new(name: 'serv1', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    expect(s1.valid?).to eq(false)
  end

  it 'should return false if name is empty' do
    s1 = Service.new(price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
    expect(s1.valid?).to eq(false)
  end

  it 'should return false if description is empty' do
    s1 = Service.new(name: 'serv1', price: '15', image_url: 'www.image.com', schedule: '9:00,10:00')
    expect(s1.valid?).to eq(false)
  end

  it 'should return false if image is empty' do
    s1 = Service.new(name: 'serv1', price: '15', description: 'test', schedule: '9:00,10:00')
    expect(s1.valid?).to eq(false)
  end

  it 'should return false if schedule is emptyd' do
    s1 = Service.new(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com')
    expect(s1.valid?).to eq(false)
  end
end
