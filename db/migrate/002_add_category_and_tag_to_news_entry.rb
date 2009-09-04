require 'active_record/fixtures'

class AddCategoryAndTagToNewsEntry < ActiveRecord::Migration
  def self.up
    add_column :news_entries, :news_category_id, :integer
    
    create_table :news_categories, :force => true do |t|
      t.string :name
    end
    
    create_table :news_tags, :force => true do |t|
      t.string :name
    end
    
    create_table :news_entries_news_tags, :force => true, :id => false do |t|
      t.integer :news_entry_id
      t.integer :news_tag_id
    end    

    create_table :news_entries_news_categories, :force => true,:id => false do |t|
      t.integer :news_entry_id
      t.integer :news_category_id
    end    
    
    #NewsCategory.new(:name => "uncategorized", :id => 1).save!
    directory = File.join(File.dirname(__FILE__), 'init_data')
    Fixtures.create_fixtures(directory, 'news_categories')
    
  end

  def self.down
    remove_column :news_entries, :news_category_id
    drop_table :news_categories
    drop_table :news_tags
    drop_table :news_entries_news_tags
    drop_table :news_entries_news_categories
  end
end
