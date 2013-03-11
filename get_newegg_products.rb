require 'net/http'
require 'uri'
require 'json'

def get_products(node_id)
  data = {
    'NodeId'     => node_id,
    'PageNumber' => 1
  }.to_json
  headers = {
    'User-Agent' => 'Newegg Ruby Scraper Version 1.0',
    'Content-Type' => 'application/json'
  }
  
  uri = URI.parse('http://www.ows.newegg.com/Search.egg/Advanced')
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, initheader = headers)
  request.body = data
  response = http.request(request)
  first_page = JSON.parse(response.body)
  total_count = first_page['PaginationInfo']['TotalCount']
  page_size = first_page['PaginationInfo']['PageSize']
  total_pages = (total_count.to_f/page_size.to_f).ceil

  (1..total_pages).each do |page_number|
    page = get_page(node_id, page_number)
    for product in page['ProductListItems']
      puts product  
    end  
  end
end

def get_page(node_id, page_number) 
  data = {
    'NodeId'     => node_id,
    'PageNumber' => page_number
  }.to_json
  headers = {
    'User-Agent' => 'Newegg Ruby Scraper Version 1.0',
    'Content-Type' => 'application/json'
  }
  
  uri = URI.parse('http://www.ows.newegg.com/Search.egg/Advanced')
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, initheader = headers)
  request.body = data
  response = http.request(request)
  JSON.parse(response.body)
end

get_products(7611)