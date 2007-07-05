require 'mt-capistrano'

set :site,         "1439"
set :application,  "wikicontrails"
set :webpath,      "wikicontrails.gandrew.com"
set :domain,       "gandrew.com"
set :user,         "serveradmin%gandrew.com"
set :password,     "xxxx"
ssh_options[:password] = "xxxx"
set :svn_password, "xxxx"

# repository on (gs)
set :repository, "svn+ssh://#{user}@#{domain}/home/#{site}/users/.home/repos/wikicontrails/trunk"

# these shouldn't be changed
role :web, "#{domain}"
role :app, "#{domain}"
role :db,  "#{domain}", :primary => true
set :deploy_to,    "/home/#{site}/containers/rails/#{application}"

#set :migrate_env, "VERSION=0"

task :after_symlink, :roles => :app do
  run "#{mtr} -u #{user} -p #{password} generate_htaccess #{application}"
end

task :after_update_code, :roles => [:web] do
  run "cp /home/#{site}/containers/rails/#{application}/shared/system/config/database.yml #{release_path}/config/database.yml"
  run <<-EOF
    source ~/.bash_profile &&
    cd #{release_path} &&
    rake RAILS_ENV=production db:migrate
  EOF
end