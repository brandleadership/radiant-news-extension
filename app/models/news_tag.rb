class NewsTag < ActiveRecord::Base
  has_and_belongs_to_many :news_entries, :join_table => 'news_entries_news_tags'
  def to_s
    name
  end
end
