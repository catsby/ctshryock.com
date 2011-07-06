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

set :title, ENV['title'] if ENV['title']
set :category,       ENV['cat'] ? ENV['cat'] : 'post' 

namespace :deploy do
end

namespace :post do
  desc <<-DESC
    Create a new post with a given title
  DESC
  task :default do
    puts "Cat: #{category}"
    create_post
  end
  
end

def create_post
    puts "Creating: #{file_path}"
    new_post = File.new(file_path, "w")
    new_post.write(create_header)
    new_post.close
end

def create_header
  header =  "---\n"
  header << "layout: #{post_layout}\n"
  header << "date: #{Time.now.to_s}\n"
  header << "title: \"#{post_title}\"\n"
  if web_error
    header << "image: \n"
    header << "alt: \n" 
    header << "note: \n" 
  end
  header << "category: #{web_error.gsub('/', '')}\n" if web_error
  header << "---\n" 
  header
end

def post_name
  post_title.gsub(' ', '-').downcase
end

def post_title
  title
end

def post_date
  Time.now.strftime("%Y-%m-%d")
end

def post_layout
  if category =~ /web-error/
    'web-errors'
  else 
    'post'
  end
end

def web_error
  'web-errors/' if category =~ /web-error/
end

def file_path
  "_posts/#{web_error}#{post_date}-#{post_name}.md"
end
