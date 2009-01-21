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
    @news = News.new( :leadtext => 'test')
  end

  it "should not be saved" do
    @news.save().should be_false
  end
end

describe 'saving a news with just start date should not be possible' do
  before(:each) do
    @news = News.new( :start => Date::today())
  end

  it "should not be saved" do
    @news.save().should be_false
  end
end