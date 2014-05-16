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

    scope :unchecked, lambda { where("checked_at IS NULL") }
    scope :not_recently_checked, lambda { where("checked_at IS NULL OR checked_at < :next_check", next_check: 1.hour.ago) }
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
