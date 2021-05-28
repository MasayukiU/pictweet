class UsersController < ApplicationController
	def show
    user = User.find(params[:id])#これを入れることでデータベースからuserを取ってきてくれる
    @nickname = user.nickname
    @tweets = user.tweets
  end
end
