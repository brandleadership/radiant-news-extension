class News < ActiveRecord::Base
  validates_presence_of  :headline
  validates_presence_of  :leadtext
  validates_presence_of  :start
end
