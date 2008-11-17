module NewsTags
    include Radiant::Taggable

  desc %{
    Gets scrolltext with active news.

    *Usage:*
    <r:news_marquee [behavior="scroll"] [direction="left"] [loop="true"] [scrollamount="1"] [scrolldelay="2"] />
  }
  tag 'news_marquee' do |tag|
    html = ''
    currentnews.each do |news|
      html += '<b>' + news.headline+'</b>: ' + news.leadtext + " "
    end
    
    content_tag(:marquee, html, 
      :behavior => tag.attr['behavior='],
      :direction => tag.attr['direction'],
      :loop => tag.attr['loop'],
      :scrollamount  => tag.attr['scrollamount'],
      :scrolldelay  => tag.attr['scrolldelay'])
  end

  desc %{
    Allow to iterate over news which are active today.
  }
  tag 'news_current' do |tag|
    result = []
    currentnews.each do |news|
      tag.locals.news = news
      result << tag.expand
    end
    result
  end

  desc %{
    Returns headline of current news
  }
  tag 'news_headline' do |tag|
    tag.locals.news.headline
  end

  desc %{
    Returns leadtext of current news
  }
  tag 'news_leadtext' do |tag|
    tag.locals.news.leadtext
  end

  desc %{
    Returns text of current news
  }
  tag 'news_text' do |tag|
    tag.locals.news.text
  end


  def currentnews
     News.find(:all, :conditions => 'start <= CURDATE() and (stop is null or stop >= CURDATE())')
  end
end
