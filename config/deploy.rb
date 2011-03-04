set :application, "ctshryock.com"

set :repository,  "set your repository location here"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "ctshryock.com", :app, :web, :db, :primary => true                       # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
end

namespace :post do
  desc <<-DESC
    Create a new post with a given title
  DESC
  task :default do
    post_title = ENV['title'] if ENV['title']
    file_name  = post_title.gsub(' ', '-')
    puts "Creating: _posts/#{file_name}.md"
    post_date = Time.now.strftime("%Y-%m-%d")
    header = "
---
layout: post
title: \"#{post_title}\"
category: 
---
" 
    new_post = File.new("_posts/#{post_date}-#{file_name}.md", "w")
    new_post.write(header.lstrip!)
    new_post.close
        
  end
  
end
