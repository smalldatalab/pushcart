require 'net/http'

class Nutritionix

  def initialize(app, key)
    @app = app
    @key = key
    @url = URI.parse('https://api.nutritionix.com/v1_1/search')
  end

  def search(query)
    params =  {
                appId:  @app,
                appKey: @key,
                limit:  1,
                fields: ['*', ''],
                query:  query
              }
    response = JSON.parse Net::HTTP.post_form(@url, params).body
    return response['hits'].first
  rescue
     p "Connection error."
  end

end