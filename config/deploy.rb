set :application, "monitor-webapp"
set :repo_url, "git@bitbucket.org:johnbrayton/monitor-webapp.git"
set :branch, "master"
set :deploy_to, "/monitor-webapp"
set :ssh_options, { forward_agent: true, user: "passenger", auth_methods: ['publickey'], keys: %w(~/.ssh/privatekey.pem) }
