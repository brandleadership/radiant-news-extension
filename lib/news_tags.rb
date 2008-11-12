module NewsTags
    include Radiant::Taggable

  desc %{
    Gets scrolltext with active news.

    *Usage:*
    <r:news_marquee>
   }
  tag 'news_marquee' do |tag|
    html = '<marquee behavior="scroll" direction="left" loop="true" scrollamount="1" scrolldelay="2">'
    News.find(:all).each do |news|
      html += '<b>' + news.headline+'</b>: ' + news.leadtext
    end
    html += '</marquee>'
  end
end
