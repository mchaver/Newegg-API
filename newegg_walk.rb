require 'net/http'
require 'uri'
require 'json'

class String
  def rchomp(sep = $/)
    self.start_with?(sep) ? self[sep.size..-1] : self
  end
end

def get_stores()
  headers = {
    'User-Agent' => 'Newegg Ruby Scraper Version 1.0',
    'Content-Type' => 'application/json'
  }

  uri = URI.parse('http://www.ows.newegg.com/Stores.egg/Menus')
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri, initheader = headers)
  response = http.request(request)
  stores = JSON.parse(response.body)

  stores.each do |store|
    categories = get_category_and_node(store['StoreID'])
    categories.each do |category|
      p category["Description"]
      p category["NodeId"]
    end
  end
end

def get_category_and_node(store_id) 
  uri = URI.parse("http://www.ows.newegg.com/Stores.egg/Categories/#{store_id}")
  headers = {
    'User-Agent' => 'Newegg Ruby Scraper Version 1.0',
    'Content-Type' => 'application/json'
  }
  
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri, initheader = headers)
  response = http.request(request)
  JSON.parse(response.body)
end

get_stores()