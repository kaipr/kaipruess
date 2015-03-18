require 'mina/bundler'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'

set :user,       'kaipr'
set :domain,     '176.9.39.143'
set :deploy_to,  '/var/www/kaipruess.de'
set :repository, 'https://github.com/kaipr/kaipruess.git'
set :branch,     'master'

set :shared_paths, ['log', 'tmp']


task :environment do
  invoke :'rbenv:load'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'puma:restart'
    end
  end
end
