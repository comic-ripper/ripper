class ScheduledWorker
  include Sidekiq::Worker

  def perform
    Comic.not_recently_checked.each &:delay_check
    Chapter.unchecked.each &:delay_check
    Page.unchecked.each &:delay_check
    Chapter.checked.unbuilt.select(&:complete?).each &:delay_build
  end
end
