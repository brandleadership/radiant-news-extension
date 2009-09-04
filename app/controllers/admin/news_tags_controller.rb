class Admin::NewsTagsController <  Admin::ResourceController
  def index
    @news_tags = NewsTag.paginate :page => params[:page], :per_page => 10
  end
end