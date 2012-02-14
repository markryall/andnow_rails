# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
AndnowServer::Application.config.secret_token = ENV['SECRET'] || '550089ec4d675f8c4e0fb8a88aa06c8e837c4b5b20da48466d626a973d567c624b18663ef0fb10edb5cc58f7b3af4294f5b68b760f45e0b9447da7cad625fd38'
