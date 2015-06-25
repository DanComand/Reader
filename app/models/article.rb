class Article < ActiveRecord::Base
	validates :url, presence: true
end
