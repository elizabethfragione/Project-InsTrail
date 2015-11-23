# Be sure to restart your server when you modify this file.

# original here
#Rails.application.config.session_store :cookie_store, key: '_InsTrail_session'

#Rails.application.config.session_store :active_record_store, :key => '_InsTrail_session'

InsTrail::Application.config.session_store :cookie_store, key: '_InsTrail_session'
