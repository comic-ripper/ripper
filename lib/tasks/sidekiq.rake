namespace :sidekiq do
  desc "Clear sidekiq jobs / stats"
  task :reset => :environment do
    Sidekiq::Queue.all.each(&:clear)
    Sidekiq::RetrySet.new.clear
    Sidekiq::Stats.new.reset
  end
end

desc "Reset everything"
task :reset => ["sidekiq:reset", "db:drop", "db:create", "db:migrate", "db:seed"]