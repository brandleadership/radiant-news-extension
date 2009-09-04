class NewsCategory < ActiveRecord::Base
  has_and_belongs_to_many :news_entries, :join_table => 'news_entries_news_categories'
  def before_destroy
    news_entries.each do |x|
      if x.news_categories == [self] #only this category
        x.news_categories = [NewsCategory.find_by_name('uncategorized')]
        x.save
      end
    end
  end
  def to_s
    name
  end
end