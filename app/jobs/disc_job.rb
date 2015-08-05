require 'disc'

class DiscJob
  include Disc::Job
  disc queue: "urgent"

  def perform(*args)
    process_id = Process.pid
    thread_id = Thread.current.object_id
    STDOUT.puts "Process #{process_id}; thread #{thread_id}"
  end
end