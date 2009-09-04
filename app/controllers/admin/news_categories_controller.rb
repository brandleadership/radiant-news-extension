class Admin::NewsCategoriesController <  Admin::ResourceController
  def index
    @news_categories = NewsCategory.paginate :page => params[:page], :per_page => 10
  end
end