module TweetsHelper #モジュールとは、Rubyにおける「インスタンスを生成できないクラス」Helperとは、ヘルパーメソッドを作成できるモジュール
  def tweet_lists(tweets)
    html = ''
    tweets.each do |tweet|
      html += render(partial: 'tweet',locals: { tweet: tweet })
    end
    return raw(html)
  end
end

# <% @tweets.each do |tweet| %>
	# <% render partial: "tweet", locals: { tweet: tweet } %>
# <% end %>