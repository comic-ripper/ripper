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
      self.class.perform_async id
    end

    scope :unchecked, -> { where("checked_at IS NULL") }
    scope :checked, -> { where("checked_at IS NOT NULL") }
    scope :not_recently_checked, -> { where("checked_at IS NULL OR checked_at < :next_check", next_check: 1.hour.ago) }

    include Sidekiq::Worker

    sidekiq_options unique: true, expiration: 1.day, queue: to_s

    def perform(id)
      self.class.find(id).check
    end

    def self.lock(id)
      "locks:unique:#{self}:#{id}"
    end

    def self.unlock!(id)
      lock = self.lock(id)
      Sidekiq.redis { |conn| conn.del(lock) }
    end
  end

  module ClassMethods
    def on_check(method)
      check_hooks << method
    end

    def check_hooks
      @check_hooks ||= []
    end

    def on_uncheck(method)
      uncheck_hooks << method
    end

    def uncheck_hooks
      @uncheck_hooks ||= []
    end
  end
end
