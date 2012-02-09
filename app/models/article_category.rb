class ArticleCategory < ActiveRecord::Base
    has_many :articles
	has_many :users, :through=> :articles
end
