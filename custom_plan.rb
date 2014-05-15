require 'zeus/rails'

class CustomPlan < Zeus::Rails

  def spec(argv=ARGV)
    require 'simplecov'
    SimpleCov.start 'rails'

    # require all ruby files
    Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }

    RSpec::Core::Runner.disable_autorun!
    exit RSpec::Core::Runner.run(["spec"] + argv)
  end
end

Zeus.plan = CustomPlan.new
