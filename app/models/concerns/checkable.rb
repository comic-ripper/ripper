module Checkable
  extend ActiveSupport::Concern

  included do
    def check
      self.class.checked.map do |method_to_check|
        send(method_to_check)
      end
      update checked_at: Time.now
    end

    def delay_check
      Checkable::Worker.perform_async self.class, id
    end
  end

  module ClassMethods
    def check(method)
      checked << method
    end

    def checked
      @checked ||= []
    end
  end

  class Worker
    include Sidekiq::Worker

    sidekiq_options unique: true, expiration: 1.day

    def perform klass, id
      klass.constantize.find(id).check
    end
  end
end
