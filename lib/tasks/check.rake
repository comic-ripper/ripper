desc "Trigger a check in sidekiq"
task check: :environment do
  ScheduledWorker.perform_async
end
