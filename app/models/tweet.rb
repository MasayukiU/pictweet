class Tweet < ApplicationRecord
	validates :text, presence: true #validates :カラム名, バリデーションの種類
	belongs_to :user #validates :user_id presence: true ←不要
	has_many :comments  # commentsテーブルとのアソシエーション

	# def self.search(search)
  #   if search != ""
  #     Tweet.where('text LIKE(?)', "%#{search}%")
  #   else
  #     Tweet.all
  #   end
  # end
end
