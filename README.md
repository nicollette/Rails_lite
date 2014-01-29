Rails Lite
==========

Re-created the basic functionality of Rails using WEBrick.

Highlights
==========

*   [https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/controller_base.rb](https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/controller_base.rb)
    *   Re-created #render_content and #redirect_to methods using WEBrick::HTTPRequest and WEBrick::HTTPResponse classes.
    
    *   Re-created #render method that reads and evaluates templates. Used the #binding method to capture the controller's instance variables.
    
*   [https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/session.rb](https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/session.rb)
    *   Saved sessions by creating a WEBrick::Cookie object and storing it in the WEBrick::HTTPResponse. 
    
*   [https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/params.rb](https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/params.rb)
    *   Used URI module to parse query string params.
    *   Used Regex matching to parse request body params.
  
*   [https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/router.rb](https://github.com/nicollette/Rails_lite/blob/master/lib/rails_lite/router.rb)
    *   Creates router and routes using metaprogramming techniques and Regex.