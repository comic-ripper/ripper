class ScheduledWorker
  include Sidekiq::Worker

  sidekiq_options unique: :all, expiration: 1.day

  def perform
    Comic.not_recently_checked.each &:delay_check
    Chapter.unchecked.limit(100).each &:delay_check
    Page.unchecked.limit(100).each &:delay_check
    Chapter.checked.unbuilt.limit(100).select(&:complete?).each &:delay_build
  end
end
