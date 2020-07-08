module Utilities
  def create_client_user
    User.create(email: 'ut1@ut1.com',
      name: 'user test 1',
      phone: '123456789',
      password: '123456',
      password_confirmation: '123456',
      role: 2)
  end
end
