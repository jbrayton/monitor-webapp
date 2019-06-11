server '45.33.79.235', user: 'passenger', roles: %w{app web}, port: 14



set :ssh_options, {
  forward_agent: true,
  keys: %w(/Users/jbrayton/.ssh/identities/server2017/id_rsa)
}

