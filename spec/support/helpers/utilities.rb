module Utilities
  def create_client_user
    User.create(email: 'ut1@ut1.com',
                name: 'user test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 0)
  end

  def create_admin_user
    User.create(email: 'admin@admin.com',
                name: 'admin test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 2)
  end

  def create_employe_user
    User.create(email: 'admin@admin.com',
                name: 'admin test 1',
                phone: '123456789',
                password: '123456',
                password_confirmation: '123456',
                role: 1)
  end

  def create_service
    Service.create(name: 'serv1', price: '15', description: 'test', image_url: 'www.image.com', schedule: '9:00,10:00')
  end

  def sign_in
    post '/signin', params: { user: { email: 'ut1@ut1.com', password: '123456' } }
  end

  def sign_in_admin
    post '/signin', params: { user: { email: 'admin@admin.com', password: '123456' } }
  end

  def log_out
    delete '/logout'
  end

  def post_appointment
    post '/appointments', params: { appointment: { date: '2020-06-28',
                                                   time: '9:00',
                                                   service_id: '1',
                                                   pet_name: 'pipe' } }
  end

  def sign_up_user
    post '/signup', params: { user: { email: 'ut1@ut1.com',
      name: 'user test 1',
      phone: '123456789',
      password: '123456',
      password_confirmation: '123456',
      token: '' } }
  end

  def sign_up_employe
    post '/signup', params: { user: { email: 'ut1@ut1.com',
      name: 'user test 1',
      phone: '123456789',
      password: '123456',
      password_confirmation: '123456',
      token: ENV['EMPLOYE_TOKEN'] } }
  end

  def sign_up_admin
    post '/signup', params: { user: { email: 'ut1@ut1.com',
      name: 'user test 1',
      phone: '123456789',
      password: '123456',
      password_confirmation: '123456',
      token: ENV['ADMIN_TOKEN'] } }
  end

  def sign_up_invalid_token
    post '/signup', params: { user: { email: 'ut1@ut1.com',
      name: 'user test 1',
      phone: '123456789',
      password: '123456',
      password_confirmation: '123456',
      token: 'invalid-token' } }
  end

  def post_service
    post '/services', params: { service: { name: 'serv22',
      price: '15',
      description: 'test',
      image_url: 'www.image.com',
      schedule: '9:00,10:00' } }
  end

  def post_invalid_service
    post '/services', params: { service: { name: 'serv1',
      price: '15',
      description: 'test',
      image_url: 'www.image.com' } }
  end

end
