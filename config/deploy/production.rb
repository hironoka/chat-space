server '35.166.45.73', user: 'hiro', roles: %w{app db web}

set :ssh_options,{ keys: %w(~/.ssh/practice_key_rsa) }
set :default_env, {
  ACCESS_KEY_ID: ENV["ACCESS_KEY_ID"],
  SECRET_ACCESS_KEY: ENV["SECRET_ACCESS_KEY"]
}
set :bundle_without, %w{development test deployment}.join(' ')
