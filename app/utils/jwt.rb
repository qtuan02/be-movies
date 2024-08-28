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
    # token = request.headers['Authorization']&.split(' ')&.last
    # unless token
    #   raise CustomError.new('Không có quyền truy cập!', :unauthorized)
    # end

    begin
      decode = JWT.decode(token, SECRET, true, algorithm: 'HS256')
      return decode
    rescue JWT::ExpiredSignature
      raise CustomError.new('Tài khoản đã hết hạn!', :unauthorized)
    rescue
      raise CustomError.new('Không có quyền truy cập!', :unauthorized)
    end
  end

end