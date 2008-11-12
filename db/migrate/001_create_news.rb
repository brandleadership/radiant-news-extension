class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :headline
      t.string :leadtext
      t.string :text
      t.date :start
      t.date :stop

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
