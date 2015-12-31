module Checkable
  extend ActiveSupport::Concern

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

  def perform(id)
    self.class.find(id).check
  end

  included do
    if defined?(scope)
      scope :unchecked, -> { where("#{table_name}.checked_at IS NULL") }
      scope :checked, -> { where("#{table_name}.checked_at IS NOT NULL") }
      scope :not_recently_checked, lambda {
        where(
          "#{table_name}.checked_at IS NULL OR #{table_name}.checked_at < :next_check",
          next_check: 1.hour.ago)
      }
    end

    include Sidekiq::Worker
    sidekiq_options unique: true, expiration: 1.day, queue: to_s
  end

  module ClassMethods
    def lock(id)
      "locks:unique:#{self}:#{id}"
    end

    def unlock!(id)
      lock = self.lock(id)
      Sidekiq.redis { |conn| conn.del(lock) }
    end

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
