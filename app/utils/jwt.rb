require 'jwt'
module Jwt
  SECRET = ENV['JWT_SECRET_KEY']

  def encoded_access_jwt(data)
    payload = data.merge(
      exp: 1.hour.from_now.to_i
    )

    JWT.encode payload, SECRET, 'HS256'
  end

  def refresh_refresh_jwt(data)
    payload = data.merge(
      exp: 1.month.from_now.to_i
    )

    JWT.encode payload, SECRET, 'HS256'
  end

  def permission_jwt(roles)
    token = request.headers['Authorization']&.split(' ')&.last
    unless token
      raise CustomError.new('Không có quyền truy cập!', :unauthorized)
    end

    begin
      decode = JWT.decode(token, SECRET, true, algorithm: 'HS256')
      puts decode
      return
    rescue JWT::ExpiredSignature
      raise CustomError.new('Tài khoản đã hết hạn!', :unauthorized)
    rescue
      raise CustomError.new('Không có quyền truy cập!', :unauthorized)
    end
  end

end