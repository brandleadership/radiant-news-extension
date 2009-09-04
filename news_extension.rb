# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration in backend and different frontend views"
  url "http://www.screenconcept.ch"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :news_entries
      admin.resources :news_tags
      admin.resources :news_categories
    end
  end
  
  def activate
    admin.tabs.add "News", "/admin/news_entries", :after => "Layouts", :visibility => [:all]
    Page.send :include,  NewsTags
  end
  
  def deactivate
    admin.tabs.remove "News"
  end
  
end
