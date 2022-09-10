server '74.207.242.231', user: 'passenger', roles: %w{app}, port: 14

set :ssh_options, {
  forward_agent: true,
  keys: %w(/Users/jbrayton/.ssh/identities/server2017/id_rsa)
}
