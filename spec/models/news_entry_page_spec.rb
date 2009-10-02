require File.dirname(__FILE__) + '/../spec_helper'

describe NewsEntryPage do
  before(:each) do
    @news_entry_page = NewsEntryPage.new
  end

  it "should be valid" do
    @news_entry_page.should be_valid
  end
end
