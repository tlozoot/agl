# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fixagl_session',
  :secret      => '3e66a936792900d4c16fe3b7163e9c0b0626fe29727bb61e388b0e21a3f07e8659362f5243e82e459d64e554228a09fab1ee5dd36bb7cc8eb69cffe54ed82429'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
