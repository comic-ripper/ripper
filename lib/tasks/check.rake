desc "Trigger a check in sidekiq"
task :check do
  ScheduledWorker.perform_async
end
