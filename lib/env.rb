class Env

  def self.base_uri
    Rails.env.production? ? 'http://www.iheartmeat.com' : 'http://www.localhost:3000'
  end

  def self.mailgun_api_key
    ENV['MAILGUN_API_KEY']
  end

end
