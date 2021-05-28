class CommentsController < ApplicationController
	def create
    comment = Comment.create(commentparams)
    redirect_to "/tweets/#{comment.tweet.id}"# コメントと結びつくツイートの詳細画面に遷移する
		#URIが/tweets/:tweet_id/comments(.:format)
		#:tweet_idの箇所へ、コメントと結びつくツイートのidを記述すると、paramsのなかにtweet_idというキーでパラメーターが追加され、コントローラーで扱うことができます。
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
