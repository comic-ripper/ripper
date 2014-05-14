## Parsers
* Parsers are not activerecord models, but they interact with comics.
* A comic knows which parser it needs to use, either through the url, or because the user told it so.
* Parsers store meta data (chapter and page urls, etc...) in the comic, chapter, and page models

```ruby
module ExampleParser
  class Comic
    def initialize(comic_url)
      @index_url = comic_url  
    end
    def chapters
      #...
      [
        {
          url: "http://example.com/chapters/1",
          title: "Ch.1: Example",
          date: "2014-1-1 13:00 -00:00"
        },
        #...
      ]
  end

  class Chapter
    def initialize(chapter_url)
      @index_url = chapter_url
    end

    def pages
      #...
      [
        {
          number: 1
          url: "http://example.com/chapters/1/pages/1"
        }
      ]
    end
  end

  class Page
    def initialize(page_url)
      @page_url = page_url
    end

    def image_url
      #...
      "http://example.com/chapters/1/pages/1.jpg"
    end
  end
end
```
