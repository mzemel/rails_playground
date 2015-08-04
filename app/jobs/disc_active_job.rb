class DiscActiveJob < ActiveJob::Base
  queue_as :urgent

  def perform(*args)
    process_id = Process.pid
    thread_id = Thread.current.object_id
    STDOUT.puts "rocess #{process_id}; thread #{thread_id}"
  end
end