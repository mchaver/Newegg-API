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
    puts store['Title']
    categories = get_category_and_node(store['StoreID'])
    categories.each do |category|
      puts "  #{category['Description']}"
      puts "  #{category['NodeId']}"
      subcategories = get_sub_category(category['StoreID'], category['CategoryID'], category['NodeId'])
      subcategories.each do |subcategory|
        puts "    #{subcategory['Description']}"
        puts "    #{subcategory['NodeId']}"
      end 
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

def get_sub_category(store_id, category_id, node_id)
  uri = URI.parse("http://www.ows.newegg.com/Stores.egg/Navigation/#{store_id}/#{category_id}/#{node_id}")
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