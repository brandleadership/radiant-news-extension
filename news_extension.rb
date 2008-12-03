# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class NewsExtension < Radiant::Extension
  version "1.0"
  description "Extension for news administration in backend and different frontend views"
  url "http://www.screenconcept.ch"
  
  define_routes do |map|
    map.with_options(:controller => 'admin/news') do |link |
      link.news_index           'admin/news',             :action => 'index'
      link.news_new             'admin/news/new',         :action => 'new'
      link.news_edit            'admin/news/edit/:id',    :action => 'edit'
      link.news_remove          'admin/news/remove/:id',  :action => 'remove'
    end
  end
  
  def activate
    admin.tabs.add "News", "/admin/news", :after => "Layouts", :visibility => [:all]
    Page.send :include,  NewsTags
  end
  
  def deactivate
    admin.tabs.remove "News"
  end
  
end
