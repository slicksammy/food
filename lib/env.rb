class Env

  BOOLEAN_ENV_REGEX = /(true|1|yes)/i

  def self.env_to_boolean(env)
    return !!(env =~ BOOLEAN_ENV_REGEX)
  end

  def self.base_uri
    Rails.env.production? ? 'http://www.iheartmeat.com' : 'http://www.localhost:3000'
  end

  def self.mailgun_api_key
    ENV['MAILGUN_API_KEY']
  end

  def self.accepting_orders?
    env_to_boolean(ENV['ACCEPTING_ORDERS'])
  end

  def self.stripe_api_key
    ENV['STRIPE_API_KEY']
  end

  def self.delivery_radius
    ENV['DELIVERY_RADIUS'].to_f
  end

end
