class CustomerService < ApplicationService
  def index
    begin
      Customer.all
    rescue
      raise StandardError
    end
  end

  def show(customer_id)
    begin
      Customer.find(customer_id)
    rescue
      raise StandardError
    end
  end

  def create(data)
    begin
      if Customer.exists?(email: data[:email])
        raise CustomError.new('Email already exists!', :bad_request)
      end
      if Customer.exists?(phone: data[:phone])
        raise CustomError.new('Phone already exists!', :bad_request)
      end

      data[:customer_id] = generate_id
      customer = Customer.new(data)
      customer.save ? customer : nil
    rescue CustomError => e
      raise e
    rescue
      raise StandardError
    end
  end

  def update(customer_id, data)
    begin
      customer = Customer.find(customer_id)
      
      if customer
        if Customer.exists?(email: data[:email]) && customer[:email] != data[:email]
          raise CustomError.new('Email already exists!', :bad_request)
        end
        if Customer.exists?(phone: data[:phone]) && customer[:phone] != data[:phone]
          raise CustomError.new('Phone number already exists!', :bad_request)
        end

        customer.update(data)
        customer
      else
        nil
      end
    rescue CustomError => e
      raise e
    rescue
      raise StandardError
    end
  end

end
