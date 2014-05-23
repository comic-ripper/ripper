class BuilderWorker
  include Sidekiq::Worker

  sidekiq_options queue: "Build", unique: :all, expiration: 1.day

  def perform chapter_id
    Chapter.find(chapter_id).build
  end
end
