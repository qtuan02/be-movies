class CountryService < ApplicationService
  def index(page = nil, limit = nil, name = nil)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if name
      
      if page && limit
        offset = (page.to_i - 1) * limit.to_i
        countries = Country.where(conditions).skip(offset).limit(limit.to_i)
      else
        countries = Country.where(conditions)
      end

      countries
    rescue
      raise StandardError
    end
  end

  def show(country_id)
    begin
      Country.find(country_id)
    rescue
      raise StandardError
    end
  end

  def create(data)
    begin
      country = Country.new(data)
      country.save ? country : nil
    rescue
      raise StandardError
    end
  end
  
  def destroy(country_id)
    begin
      country = Country.find(country_id)
      if country
        country.destroy
        country_id
      else
        nil
      end
    rescue CustomError => e
      raise e
    rescue
      raise StandardError
    end
  end

  def update(country_id, data)
    begin
      country = Country.find(country_id)
      if country
        country.update(data)
        country
      else
        nil
      end
    rescue
      raise StandardError
    end
  end
  
end