class CountryService < ApplicationService
  def index(page = nil, limit = nil, search = nil)
    begin
      query = search ? { name: /#{search}/i } : {}
      
      if page && limit
        offset = page == 1 ? 0 : (limit.to_i * page.to_i) - (limit.to_i)
        countries = Country.where(query).offset(offset).limit(limit)
      else
        countries = Country.where(query)
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