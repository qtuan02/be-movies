class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  throttle('req/ip', limit: 5, period: 10) do |req|
    req.ip
  end

  self.throttled_responder = lambda do |req|
    # puts "IP Address: #{req.ip}"

    [429, { 'Content-Type' => 'application/json' }, [{ 
        message: 'Too many request!',
        is_success: false,
        data: nil
    }.to_json]]
  end
end