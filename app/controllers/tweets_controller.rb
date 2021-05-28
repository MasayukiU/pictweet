class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]#exceptエクセプトオプションexceptは「除外する」という意味があります。こちらの後に指定したアクションに対しては、事前処理は実行されません。
  #before_actionによりmove_to_indexメソッドが先に実行され、indexアクションのindex.html.erbページにリダイレクトしてくれます

	def index
    # @tweets = Tweet.all
    # @tweets = Tweet.includes(:user) #モデル名.includes(:紐付くモデル名)includesメソッドを使用してN+1問題を解消します。ちなみに、includesメソッドを使用するとすべてのレコードを取得するため、allメソッドは省略可能です。
    @tweets = Tweet.includes(:user).order("created_at DESC")#	インスタンス = モデル名.order("並び替えの基準となるカラム名 並び順")
    #render json: @tweets #
  end

  def new #CRUDのC（CREATE）インスタンスの生成
    @tweet = Tweet.new
  end

  def create #CRUDのC（CREATE）
    Tweet.create(tweet_params)
  end

  def destroy #CRUDのD（DELETE）
    tweet = Tweet.find(params[:id]) 
    tweet.destroy
  end

  def edit #CRUDのU（UPDATE）
    # @tweet = Tweet.find(params[:id])#set_tweetへ
  end

  def update #CRUDのU（UPDATE）
    tweet = Tweet.find(params[:id]) #なんでfindなんだろう？
    tweet.update(tweet_params)
  end

  def show
    # @tweet = Tweet.find(params[:id])#set_tweetへ
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)#モデル名.includes(:紐付くモデル名)
  end

  # def search
  #   @tweets = Tweet.search(params[:keyword])
  # end

  def search
    @tweets = SearchTweetsService.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)#params.require(:モデル名).permit(:キー名, :キー名),current_userメソッド
    #requireメソッドは送信されたパラメーターの情報を持つparamsが、使用できるメソッドparamsが使用できるメソッドです。
    #permitメソッドを使用すると、取得したいキーを指定でき、指定したキーと値のセットのみを取得します
    #margeメソッド ハッシュを結合させるときに使用するRubyのメソッド
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index 
    unless user_signed_in?# unless 条件式 ユーザーがログインしていない場合indexに戻るメソッド
      redirect_to action: :index #redirect_to action: :リダイレクト先となるアクション名
    end
  end
end
