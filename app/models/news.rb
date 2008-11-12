class News < ActiveRecord::Base
  validates_presence_of  :headline
end
