require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def spec(argv=ARGV)
# disable autorun in case the user left it in spec_helper.rb
    RSpec::Core::Runner.disable_autorun!
    exit RSpec::Core::Runner.run(["spec"] + argv)
  end

  def sidekiq(_argv = ARGV)
    require 'sidekiq/cli'
    begin
      cli = Sidekiq::CLI.instance
      cli.parse
      cli.run
    rescue => e
      STDERR.puts e.message
      STDERR.puts e.backtrace.join("\n")
      exit 1
    end
  end
end

Zeus.plan = CustomPlan.new
