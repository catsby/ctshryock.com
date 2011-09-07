set :application, "ctshryock.com"

set :repository,  "clint@localhost:webapps/git/repos/ctshryock.com.git"
set :deploy_via, :remote_cache
set :deploy_to, '/home/clint/webapps/htdocs/'

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "ctshryock.com", :app, :web, :db, :primary => true                       # Your HTTP server, Apache/etc


set :title, ENV['title'] if ENV['title']
set :category,       ENV['cat'] ? ENV['cat'] : 'post' 

namespace :deploy do
end

namespace :post do
  desc <<-DESC
    Create a new post with a given title
  DESC
  task :default do
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
  header << "category: #{get_category}"
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
    'web-error'
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

def get_category
  if web_error
    "#{web_error.gsub('/', '')}\n" 
  else
    "posts\n"
  end
end
