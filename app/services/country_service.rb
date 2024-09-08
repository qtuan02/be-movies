class CountryService < ApplicationService
  def index(page, limit, name)
    begin
      conditions = {}
      conditions[:name] = /#{name}/i if name

      page = page ? page.to_i : 1
      limit = limit ? limit.to_i : 5

      offset = (page - 1) * limit
      countries = Country.where(conditions).order(created_at: :desc).skip(offset).limit(limit)

      total_pages = (Country.where(conditions).count.to_f / limit).ceil

      { total_pages: total_pages, countries: countries }
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