# Be sure to restart your server when you modify this file.

MycardServerHttp::Application.config.session_store :cookie_store, key: '_mycard-server-http_session', :expire_after => 9999.years

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# MycardServerHttp::Application.config.session_store :active_record_store
