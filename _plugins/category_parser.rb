module Jekyll
  module CategoryParser
    $category_ids = {
      "index" => "About",
      "photography" => "Photographs",
      "blog" => "Blog",
      "100miles" => "The 100 mile diet",
      "pinkerbook" => "\"The better angels of our nature\" by Steven Pinker",
      "diamondbook" => "\"Guns, germs, and steel\" by Jared Diamond",
      "publications" => "Publications",
      "zinnbook" => "\"A people's history of the USA\" by Howard Zinn"
    }

    $category_groups = {
      "index" => "general",
      "photography" => "general",
      "blog" => "general",
      "100miles" => "projects",
      "pinkerbook" => "booknotes",
      "diamondbook" => "booknotes",
      "publications" => "general",
      "zinnbook" => "booknotes"
    }

    $category_images = {
      "index" => "misty_trees.jpg",
      "blog" => "misty_trees.jpg",
      "100miles" => "slanted_trees.jpg",
      "pinkerbook" => "battle.jpg",
      "diamondbook" => "buildings.jpg",
      "publications" => "blur_road.jpg",
      "zinnbook" => "moss_pots.jpg"
    }

    def parse_category(category)
        if $category_ids[category] == nil
        return category
      else 
        return $category_ids[category]
      end
    end

    def category_group(category)
        if $category_groups[category] == nil
        return nil
      else 
        return $category_groups[category]
      end
    end

    def category_image(category)
        if $category_images[category] == nil
        return nil
      else 
        return $category_images[category]
      end
    end

  end
end
 
Liquid::Template.register_filter(Jekyll::CategoryParser)