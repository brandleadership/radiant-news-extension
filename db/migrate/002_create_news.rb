class CreateNews < ActiveRecord::Migration
  def self.up
    change_column :news, :text, :text
  end

  def self.down
     change_column :news, :text, :string
  end
end