# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration in backend and different frontend views"
  url "http://www.screenconcept.ch"
  
  define_routes do |map|
    map.connect 'admin/news/:action', :controller => 'admin/news'
  end
  
  def activate
    admin.tabs.add "News", "/admin/news", :after => "Layouts", :visibility => [:all]
    Page.send :include,  NewsTags
  end
  
  def deactivate
    admin.tabs.remove "News"
  end
  
end
