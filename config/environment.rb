Encoding.default_internal, Encoding.default_external = ['utf-8'] * 2
# Load the rails application
require File.expand_path('../application', __FILE__)
require File.expand_path('../../lib/mysql_utf8.rb', __FILE__)
# Initialize the rails application
Reliz::Application.initialize!
