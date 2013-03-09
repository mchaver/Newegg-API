Newegg-API
==========

Some simple scripts to get products from Newegg. Great if you are building a service that relies on data from Newegg, or you are just curious what they have.

Inspired by [Newegg's JSON API](http://www.bemasher.net/archives/1002), which is written in Python. I wanted to make a simpler version in Ruby.

####newegg_walk.rb 
- - -
Prints out all of the Node IDs for each product category.
####get_newegg_products.rb 
- - - 
Prints out all of the product JSONs for a single Node ID.
####get_newegg_products_threaded.rb
- - -
Same as get_newegg_products.rb except it is threaded so it runs a lot faster. It is preferred to use this version.