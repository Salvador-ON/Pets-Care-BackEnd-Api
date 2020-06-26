if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_authentication_app", domain: "" #app back end
else
  Rails.application.config.session_store :cookie_store, key: "_authentication_app"
end   