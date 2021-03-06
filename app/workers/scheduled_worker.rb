class ScheduledWorker
  include Sidekiq::Worker

  sidekiq_options unique: :all, expiration: 1.day

  def perform
    Comic.not_recently_checked.each(&:delay_check)
    Chapter.unchecked.limit(2000).each(&:delay_check)
    Page.chapter_order.unchecked.limit(2000).each(&:delay_check)
    Chapter.checked.unbuilt.limit(100).select(&:complete?).each(&:delay_build)
  end
end
