require File.dirname(__FILE__) + '/../spec_helper'
def createNews
  category1 = NewsCategory.new(:name => 'Category 1')        
  category2 = NewsCategory.new(:name => 'Category 2')        
  tag1 = NewsTag.new(:name => 'Tag 1')        
  tag2 = NewsTag.new(:name => 'Tag 2')        
  
  NewsEntry.new(:headline => 'test 4', :leadtext => 'test 4', :start => Date::today()).save  
  NewsEntry.new(:headline => 'test 3', :leadtext => 'test 3', :start => Date::today(), :news_categories => [category1], :news_tags => [tag1]).save  
  NewsEntry.new(:headline => 'test 2', :leadtext => 'test 2', :start => Date::today(), :news_categories => [category1], :news_tags => [tag1]).save  
  NewsEntry.new(:headline => 'test 1', :leadtext => 'test 1', :start => Date::today(), :news_tags => [tag1]).save  
  NewsEntry.new(:headline => 'test Tag 2', :leadtext => 'Lead Tag 2', :start => Date::today(), :news_categories => [category2], :news_tags => [tag2]).save
  NewsEntry.new(:headline => 'test Tag 1', :leadtext => 'Lead Tag 1', :start => Date::today(), :news_categories => [category1], :news_tags => [tag1]).save
  NewsEntry.new(:headline => 'test Category 2', :leadtext => 'Lead Category 2', :start => Date::today(), :news_categories => [category2]).save
  NewsEntry.new(:headline => 'test Category 1', :leadtext => 'Lead Category 1', :start => Date::today(), :news_categories => [category1]).save
end

describe 'NewsTags' do
  dataset :pages
  before do
    NewsCategory.new(:name => 'uncategorized').save!
  end
  
  #test main tags
  describe '<r:news>' do
    it 'should render the current news' do
      tag = '<r:news:current/>'
            expected = %{}
      pages(:home).should render(tag).as(expected)
    end
  end

  #test retrive all news
  describe '<r:news:current><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render the current news' do
      tag = %{<r:news:current><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Category 1
Lead Category 1
test Category 2
Lead Category 2
test Tag 1
Lead Tag 1
test Tag 2
Lead Tag 2
test 1
test 1
test 2
test 2
test 3
test 3
test 4
test 4
}
      pages(:home).should render(tag).as(expected)
    end
  end
  
    #test one category  
   describe '<r:news:current category="Category 1"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render the current news filter by \'Category 1\'' do
      tag = %{<r:news:current category="Category 1"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Category 1
Lead Category 1
test Tag 1
Lead Tag 1
test 2
test 2
test 3
test 3
}
      pages(:home).should render(tag).as(expected)
    end
  end

    #test multiple category filter
   describe '<r:news:current category="Category 1, Category 2"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render the current news filter by \'Category 1\' and \'Category 2\'' do
      tag = %{<r:news:current category="Category 1, Category 2"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Category 1
Lead Category 1
test Category 2
Lead Category 2
test Tag 1
Lead Tag 1
test Tag 2
Lead Tag 2
test 2
test 2
test 3
test 3
}
      pages(:home).should render(tag).as(expected)
    end
  end
  
  #test count limit filter
  describe '<r:news:current limit="1"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render only one current news ' do
      tag = %{<r:news:current limit="1"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Category 1
Lead Category 1
}
      pages(:home).should render(tag).as(expected)
    end
  end

  #test offset with limit filter
  describe '<r:news:current offset="1" limit="1"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render only one current news #2' do
      tag = %{<r:news:current offset="1" limit="1"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Category 2
Lead Category 2
}
      pages(:home).should render(tag).as(expected)
    end
  end
  
  #test one tag  
   describe '<r:news:current tag="Tag 1"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render the current news filter by \'Tag 1\'' do
      tag = %{<r:news:current tag="Tag 1"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Tag 1
Lead Tag 1
test 1
test 1
test 2
test 2
test 3
test 3
}
      pages(:home).should render(tag).as(expected)
    end
  end

  #test multiple tag  
   describe '<r:news:current tag="Tag 1, Tag 2"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render the current news filter by \'Tag 1\'' do
      tag = %{<r:news:current tag="Tag 1, Tag 2"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test Tag 1
Lead Tag 1
test Tag 2
Lead Tag 2
test 1
test 1
test 2
test 2
test 3
test 3
}
      pages(:home).should render(tag).as(expected)
    end
  end
  
  #test all attribute  
   describe '<r:news:current category="Category 1" tag="Tag 1" offset="1" limit="1"><r:news:headline /><r:news:leadtext /><r:news:text /></r:news:current>' do
    before do
      createNews      
    end
    
    it 'should render the current news filter by \'Tag 1\'' do
      tag = %{<r:news:current category="Category 1" tag="Tag 1" offset="1" limit="1"><r:news:headline />
<r:news:leadtext />
<r:news:text /></r:news:current>}
            expected = %{test 2
test 2
}
      pages(:home).should render(tag).as(expected)
    end
  end
end
