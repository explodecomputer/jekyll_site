module Jekyll
  module PostAndCategoryFilter
    
    def make_link(posts)

      out = []
      for post in posts
        link1 = "<a href='#{post.url}'>#{post.title}</a>"
        taglist = ""
        for tag in post.taglist
          taglist = "#{taglist}<code>#{tag}</code>"
        end

        out.push("<li><span>#{post.date.date_to_string}</span> &raquo; #{link1}<br/>#{post.excerpt}#{link2}</li>")
      end
      out
    end
  end
end

Liquid::Template.register_filter(Jekyll::PostAndCategoryFilter)