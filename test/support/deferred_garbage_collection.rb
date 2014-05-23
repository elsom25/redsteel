# @see: http://signalvnoise.com/posts/2742-the-road-to-faster-tests?33#comments
class DeferredGarbageCollection
  DEFERRED_GC_THRESHOLD = (ENV['DEFER_GC'] || 10.0).to_f
  @@last_gc_run = Time.now

  class << self
    def start
      GC.disable if DEFERRED_GC_THRESHOLD > 0
    end

    def reconsider
      return unless DEFERRED_GC_THRESHOLD > 0 && Time.now - @@last_gc_run >= DEFERRED_GC_THRESHOLD

      GC.enable
      GC.start
      GC.disable
      @@last_gc_run = Time.now
    end
  end
end
