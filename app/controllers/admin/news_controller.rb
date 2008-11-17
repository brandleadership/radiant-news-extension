class Admin::NewsController < ApplicationController

  def index
    @news = News.find(:all)
  end

  def new
    @news  = News.new
  end

  def create
    @newsNew = News.new(params[:news])
    
    if @newsNew.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
   @news = News.find(params[:id])
  end

  def update
    @news  = News.find(params[:id])

    if @news.update_attributes(params[:news])
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def remove
    @news = News.find(params[:id])
    @news.destroy
    redirect_to :action => 'index'
  end
end