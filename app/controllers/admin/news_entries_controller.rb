class Admin::NewsEntriesController <  Admin::ResourceController
  def tags_to_arr(tag_str)    
    tags = params[:news_entry][:news_tags].split(",")
    tag_str.split(",").map do |tag|
      tag.strip!      
      tag_object = NewsTag.find_by_name(tag) || NewsTag.new(:name => tag)       
    end
  end
  
  def create
    @news_categories = NewsCategory.find(:all, :order => "name ASC")        
    params[:news_entry][:news_tags] = tags_to_arr(params[:news_entry][:news_tags])
    super
  end
  
  def update
    params[:news_entry][:news_category_ids] ||= []         
    params[:news_entry][:news_tags] = tags_to_arr(params[:news_entry][:news_tags])
    super
  end
  
  def new
    @news_categories = NewsCategory.find(:all, :order => "name ASC")
  end
  def edit
    @news_categories = NewsCategory.find(:all, :order => "name ASC")    
  end
  
  def index
    @news_entries = NewsEntry.paginate :page => params[:page], :per_page => 10
  end
end