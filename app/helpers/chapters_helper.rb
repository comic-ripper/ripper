module ChaptersHelper
  def link_to_next_chapter text, chapter, **args
    if chapter.next
      link_to text, chapter.next, **args
    else
      link_to text, chapter.comic, **args
    end
  end

  def link_to_prev_chapter text, chapter, **args
    if chapter.prev
      link_to text, chapter.prev, **args
    else
      link_to text, chapter.comic, **args
    end
  end
end
