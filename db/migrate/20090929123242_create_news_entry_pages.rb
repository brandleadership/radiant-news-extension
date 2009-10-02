class CreateNewsEntryPages < ActiveRecord::Migration
  def self.up
    create_table :news_entry_pages do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :news_entry_pages
  end
end
