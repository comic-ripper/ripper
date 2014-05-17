module Checkable
  extend ActiveSupport::Concern

  included do
    def check
      self.class.check_hooks.map do |hook|
        send(hook)
      end
      self.checked_at = Time.now
      save if persisted?
    end

    def uncheck
      self.class.uncheck_hooks.map do |hook|
        send(hook)
      end
      self.checked_at = nil
      save if persisted?
    end

    def checked?
      !checked_at.nil?
    end

    def delay_check
      Checkable::Worker.perform_async self.class, id
    end

    scope :unchecked, lambda { where("checked_at IS NULL") }
    scope :checked, lambda { where("checked_at IS NOT NULL") }
    scope :not_recently_checked, lambda { where("checked_at IS NULL OR checked_at < :next_check", next_check: 1.hour.ago) }
  end

  module ClassMethods
    def on_check(method)
      check_hooks << method
    end

    def check_hooks
      @check_hooks ||= []
    end

    def on_uncheck (method)
      uncheck_hooks << method
    end

    def uncheck_hooks
      @uncheck_hooks ||= []
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
