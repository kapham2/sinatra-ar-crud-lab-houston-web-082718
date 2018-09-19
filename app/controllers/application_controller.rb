
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # renders the new.erb view.
  get '/posts/new' do
    erb :new
  end

  # /posts should use the Create CRUD action to create the blog post and save it to the database.
  post '/posts' do
    post = Post.create(name: params[:name], content: params[:content])
    # will trigger a render of an index.erb file automatically
    redirect '/posts'
  end

  # The show action should render the erb view show.erb, which shows an individual post. 
  # The index action should render the erb view index.erb, which shows a list of all of the posts.

  # Create the get '/posts' controller action. This action should use Active Record to grab 
  # all of the posts and store them in an instance variable, @posts. Then, it should render 
  # the index.erb view. That view should use erb to iterate over @posts and render them on the page.
  get '/posts' do
    @posts = Post.all

    erb :index
  end

  # Create the get '/posts/:id' controller action. This action should use Active Record 
  # to grab the post with the id that is in the params and set it equal to @post. Then, 
  # it should render the show.erb view page. That view should use erb to render the @post's 
  # title and content.
  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :show
  end

  # Create a controller action, get '/posts/:id/edit', that renders the view, edit.erb. 
  # This view should contain a form to update a specific blog post and POSTs to a controller 
  # action, patch '/posts/:id'.
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])

    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.update(name: params[:name])
    post.update(content: params[:content])

    redirect "/posts/#{post.id}"
  end

  # The Delete CRUD action corresponds to the delete controller action, delete '/posts/:id/delete'. 
  # To initiate this action, we'll just add a "delete button" to the show page. This "button" will 
  # actually be a form, disguised as a button (intriguing, I know). The form will send a POST 
  # request to the delete controller action, where we will identify the post to delete and delete it. 
  # Then, the action should render a delete.erb view which confirms that the post has been deleted.

  # get '/posts/:id/delete' do
  #   @post = Post.find(params[:id])

  #   erb :delete
  # end

  delete '/posts/:id' do
    post = Post.find(params[:id])

    post.destroy

    redirect "/posts"
  end

end