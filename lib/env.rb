class Env

  def self.base_uri
    Rails.env.production? ? 'http://www.iheartmeat.com' : 'http://www.localhost:3000'
  end

end
