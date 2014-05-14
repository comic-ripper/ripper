class Comic < ActiveRecord::Base
  include Checkable

  check def index
    puts "I've been checked"
  end

  check def ive_been_shot
    puts "#{id} has been shot"
  end
end
