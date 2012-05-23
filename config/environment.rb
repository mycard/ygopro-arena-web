# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MycardServerHttp::Application.initialize!
Mime::Type.register 'application/octet-stream', :ydk
Mime::Type.register 'application/octet-stream', :yrp
Mime::Type.register 'application/octet-stream', :deck
