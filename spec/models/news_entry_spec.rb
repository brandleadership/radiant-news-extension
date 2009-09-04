require File.dirname(__FILE__) + '/../spec_helper'

describe 'empthy news should not be saved' do
  before(:each) do
    @news = NewsEntry.new
  end

  it "should not be saved" do
    @news.save().should be_false
  end
end

describe 'saving a new with all mendatory attributes' do
  before(:each) do
    @news = NewsEntry.new(:headline => 'test', :leadtext => 'test', :start => Date::today())
  end

  it "should be saved" do
    @news.save().should be_true
  end
end

describe 'saving a news with just headline should not be possible' do
  before(:each) do
    @news = NewsEntry.new(:headline => 'test')
  end

  it "should not be saved" do
    @news.save().should be_false
  end
end

describe 'saving a news with just leadtext should not be possible' do
  before(:each) do
    @news = NewsEntry.new( :leadtext => 'test')
  end

  it "should not be saved" do
    @news.save().should be_false
  end
end

describe 'saving a news with just start date should not be possible' do
  before(:each) do
    @news = NewsEntry.new( :start => Date::today())
  end

  it "should not be saved" do
    @news.save().should be_false
  end
end

describe 'deleting a category will result news that only have that category becomes uncategorized' do
  before(:each) do
    @news = NewsEntry.new(:headline => 'test', :leadtext => 'test', :start => Date::today())
    @news2 = NewsEntry.new(:headline => 'test 2', :leadtext => 'test 2', :start => Date::today())
    @cat1 = NewsCategory.new(:name => 'cat 1')
    @cat2 = NewsCategory.new(:name => 'cat 2')
    @news.news_categories = [@cat1, @cat2]
    @news2.news_categories = [@cat1]
  end
  it "category should be uncategorized" do
    @news.save
    @news2.save
    @cat1.destroy
    @news = NewsEntry.find_by_id(@news)
    @news2 = NewsEntry.find_by_id(@news2)
    @news2.news_categories.should  == [NewsCategory.find_by_name('uncategorized')]
    @news.news_categories.should == [@cat2]
  end
end