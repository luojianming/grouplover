require "bundler/capistrano"

server "166.111.70.158", :web, :app, :db, primary: true

set :application, "grouplover"
set :user, "ljm"
set :deploy_to, "/home/#{user}/grouplover_v2"
set :deploy_via, :remote_cache
set :use_sudo, true
set :bundle_cmd, 'source $HOME/.bash_profile && bundle'
set :scm, "git"
set :repository, "git@github.com:luojianming/grouplover.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
default_run_options[:shell] = false

after "deploy", "deploy:cleanup" # keep only the last 5 releases


namespace :deploy do
=begin
  %w[start stop restart].each do |command|
    desc "#{command} thin server"
    task command, roles: :app, except: {no_release: true} do
      run "sudo service thin #{command}"
    end
  end
=end
  namespace :thinking_sphinx do
    task :stop, :roles => :app do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake ts:stop"
    end

    task :restart, :roles => :app do
      run "cd #{release_path} && RAILS_ENV=#{rails_env} bundle exec rake ts:stop ts:rebuild"
    end
  end

 # before 'deploy:update_code', 'deploy:thinking_sphinx:stop'
  after 'deploy:restart', 'deploy:thinking_sphinx:restart'


  task :setup_config, roles: :app do
=begin
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
=end
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"
 
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

