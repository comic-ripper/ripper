desc "Clean out data folder and remove pages that aren't in the database."
task :clean => :environment do
  Comic.all.each do |comic|
    comic.chapters.each do |chapter|
      if chapter.complete? # If a chapter isn't complete we might delete an imported file
        page_files = chapter.pages.map &:filename
        all_files = page_files[0].dirname.children
        if all_files.count != page_files.count
          extra = all_files - page_files
          binding.pry
        end
      end
    end
  end
end