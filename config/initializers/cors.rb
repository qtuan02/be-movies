# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete],
      credentials: false
  end
end
