Rails.application.config.middleware.insert_before 0, Rack::Cors do  
  methods = %i(get post put patch delete options head)  
  url = (Rails.env.production? ? "https://pets-care.netlify.app" : "https://localhost:3000")
  allow do    
    origins url    
    resource '*', headers: :any, methods: methods, credentials: true  
  end
end

