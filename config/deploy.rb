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

set :post_title, ENV['title'] if ENV['title']
set :post_date,  ENV['date'] ? ENV['date'] : Time.now.strftime("%Y-%m-%d")
set :category,   ENV['cat']  ? ENV['cat']  : nil
set :ptype,       ENV['type'] ? ENV['type'] : nil

namespace :deploy do
end

namespace :post do
  desc <<-DESC
    Create a new post with a given title
  DESC
  task :default do
    create_post
  end
  
  desc <<-DESC
    Create a new web-error post
  DESC
  task :web_error do
    set :ptype, 'web-error'
    create_post
  end
  
end

def create_post
    puts "Creating: _posts/#{ptype}/#{post_date}-#{post_name}.md"
    new_post = File.new("_posts/#{post_type}#{post_date}-#{post_name}.md", "w")
    new_post.write(create_header)
    new_post.close
end

def create_header
  header =  "---\n"
  header << "layout: post\n"
  header << "title: \"#{post_title}\"\n"
  header << "category: #{category}\n"
  header << "---\n" 
  header
end

def post_name
  post_title.gsub(' ', '-')
end

def post_type
  if ptype == 'web-error'
    set :category, 'web-errors'
    set :ptype, 'web-errors/'
  end 
  ptype
end
