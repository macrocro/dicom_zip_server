# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Dicom::Application.config.secret_key_base = 'ed91660b943f8e47740be552735fd89386a3ac9e4048dfe1fd5e11299884f3888dd5f22fc4595cbab46b8b47e0d9cbff22da40384da4b289b0fd1445b9c44969'
