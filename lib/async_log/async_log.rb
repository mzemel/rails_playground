# Call with:

# raise SomeError, "message"
# rescue Exception => e
# AsyncLog.log(e)
# raise e # Don't know if we should re-raise log to be minimally invasive; probably yes to start

require 'disque'

module AsyncLog
  class << self

    def client
      @client ||= Disque.new("127.0.0.1:7711")
    end

    def log(exception)
      client.push("async_queue", exception.message, 1000)
    end
   end
 end
