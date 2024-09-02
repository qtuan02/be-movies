require 'jwt'
module Jwt
  SECRET = ENV['JWT_SECRET_KEY']

  def encoded_access_jwt(data)
    payload = data.merge(
      exp: 1.hour.from_now.to_i
    )

    JWT.encode payload, SECRET, 'HS256'
  end

  def encoded_refresh_jwt(data)
    payload = data.merge(
      exp: 1.month.from_now.to_i
    )

    JWT.encode payload, SECRET, 'HS256'
  end

  def decoded_jwt(token)
    begin
      decode = JWT.decode(token, SECRET, true, algorithm: 'HS256')
      decode[0] # payload
    rescue
      raise StandardError
    end
  end

end