require 'httparty'

class Mailgun 

  URL = 'https://api:key-aa11b8fc42be916c126e4f15c25d4d5e@api.mailgun.net/v3/sandbox93f6473a97db4bc4a73145414370813c.mailgun.org/messages'

  DEFAULT_FROM = 'sam@brokolly.com'

  def deliver!(params)
    HTTParty.post(URL, {body: params})
  end
end
