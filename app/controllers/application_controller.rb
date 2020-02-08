
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect "/articles/new"
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find_by_id(params[:id])
    new_hash = {:title => "#{params[:title]}", :content => "#{params[:content]}"}
    article.update(new_hash)
    redirect "articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    Article.find_by_id(params[:id]).destroy
    redirect "/articles"
  end
end
