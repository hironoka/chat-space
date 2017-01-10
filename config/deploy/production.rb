server '35.166.45.73', user: 'hirono', roles: %w{app db web}

set :ssh_options, keys: '~/.ssh/practice_key_rsa' 
