Rails.application.config.middleware.insert_before 0, Rack::Cors do
  if Rails.env == "production"
    allow do
      origins 'https://auth-api-front.herokuapp.com' ##app front end
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  else
    allow do
      origins 'http://localhost:3000'
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
    end
  end
end   

