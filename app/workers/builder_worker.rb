class BuilderdWorker
  include Sidekiq::Worker

  sidekiq_options unique: :all, expiration: 1.day

  def perform chapter_id
    Chapter.find(id).build
  end
end
