namespace :import do
  task :urls => :environment do
    pages = JSON.load(Rails.root + "db" + "import" + "pages.json")

    pages.each do |page|
      Sidekiq.redis do |con|
        con.set "import_url:#{page["url"]}", page["image_url"]
      end
    end
  end

  task :comics => :environment do
    comics = JSON.load File.read(Rails.root + 'db' + 'import' + 'comics.json')
    comics.map! do |comic|
      Comic.new(
        title: comic["title"],
        parser: {
          json_class: "BatotoRipper::Comic",
          url: comic["url"],
          language: comic["language"]
        }
      )
    end
    Comic.import comics
  end

  task :pages => :environment do
    Sidekiq.redis do |con|
      Page.where("created_at = updated_at").each do |page|
        url_key = "import_url:#{page.parser.url}"

        image_url = con.get url_key

        if image_url
          page.parser.image_url = image_url
          page.save!
          con.del url_key
        end
      end
    end
  end
end
