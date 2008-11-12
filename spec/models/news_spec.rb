require File.dirname(__FILE__) + '/../spec_helper'

describe News do
  before(:each) do
    @news = News.new
  end

  it "should be valid" do
    @news.should be_valid
  end
end
