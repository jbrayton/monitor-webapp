set :application, "monitor-webapp"
set :repo_url, "git@github.com:jbrayton/monitor-webapp.git"
set :branch, "main"
set :deploy_to, "/monitor"
set :ssh_options, { forward_agent: true, user: "passenger", auth_methods: ['publickey'], keys: %w(~/.ssh/privatekey.pem) }
