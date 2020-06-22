require 'yaml'
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @yaml = Psych.load_file("users.yaml")
end

helpers do
  def count_interests
    users = 0
    interests = 0
    @yaml.each do |_, value|
      users += 1
      interests += value[:interests].size
    end
    "There are #{users} users with a total of #{interests} interests"
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :user_list
end

get "/users/:user" do |user|
  @user = user
  erb :user_details
end