namespace :sidekiq do
  desc "Clear sidekiq jobs / stats"
  task reset: :environment do
    Sidekiq.redis { |c| c.del(c.keys) }
  end
end

desc "Reset everything"
task reset: ["sidekiq:reset", "db:drop", "db:create", "db:migrate"] # , "db:seed"]
