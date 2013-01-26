require "bundler/capistrano"

server "166.111.70.158", :web, :app, :db, primary: true

set :application, "grouplover"
set :user, "ljm"
set :deploy_to, "/home/#{user}/grouplover_v2"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:luojianming/grouplover.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases


namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} thin server"
    task command, roles: :app, except: {no_release: true} do
      run "sudo service thin #{command}"
    end
  end



  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

