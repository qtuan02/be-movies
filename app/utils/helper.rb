require 'bcrypt'
module Helper
  def generate_id
    charset = Array('0'..'9')
    Array.new(21) { charset.sample }.join
  end

  def hash_password(password, cost = 12)
    BCrypt::Password.create(password, cost: cost)
  end

  def verify_password(hash_password, password)
    BCrypt::Password.new(hash_password) == password
  end
end