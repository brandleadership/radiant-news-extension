module NewsTags
    include Radiant::Taggable

  desc %{
    Gets scrolltext with active news.

    *Usage:*
    <r:news:marquee [behavior="scroll"] [direction="left"] [loop="true"] [scrollamount="1"] [scrolldelay="2"] />
  }
  tag 'newsMarquee' do |tag|
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

  tag 'news' do |tag|
    tag.expand
  end

  desc %{
    Allow to iterate over news which are active today.
  }
  tag 'news:current' do |tag|
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
  tag 'news:headline' do |tag|
    tag.locals.news.headline
  end

  desc %{
    Returns leadtext of current news
  }
  tag 'news:leadtext' do |tag|
    tag.locals.news.leadtext
  end

  desc %{
    Returns text of current news
  }
  tag 'news:text' do |tag|
    tag.locals.news.text
  end


  def currentnews
    curr_date = Time.now
    NewsEntry.find(:all, :conditions => ['start <=  ? and (stop is null or stop >= ?)', curr_date, curr_date])
  end
end
