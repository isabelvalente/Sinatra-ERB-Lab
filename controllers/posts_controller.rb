class PostsController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  #Set the root as the parent directory of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  #Set the view directory correctly
  set :views, Proc.new {File.join(root, "views")}

  $posts = [
    {
      :id => 0,
      :title => "Houston",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      :id => 1,
      :title => "Miami",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      :id => 2,
      :title => "New Orleans",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }

  ]

  # INDEX
  get '/' do

    @title = 'Posts Index'
    @posts = $posts

    erb :"posts/index"
  end

  # NEW
  get '/new' do

    @post = {
      :id => "",
      :title => "",
      :body =>""
    }

    erb :"posts/new"
  end

  # CREATE
  post '/' do

    id = $posts.last[:id] + 1

    new_post = {
      :id => id,
      :title => params[:title],
      :description => params[:description]
    }

    $posts.push new_post

    redirect '/'

  end

  # SHOW
  get '/:id' do
    id = params[:id].to_i

    erb :"posts/show.erb"
  end

  # EDIT
  get '/:id/edit' do

    id = params[:id].to_i
    "Edit page for #{ :id }"

    @post = $posts[id]

    erb :"posts/edit"
  end

  # UPDATE
  put '/:id' do
    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:body] = params[:body]

    $posts[id] = post

    redirect '/'
  end

  # DESTROY
  delete '/:id' do
    id = params[:id].to_i

    $posts.delete_at id

    redirect '/'

  end

end
