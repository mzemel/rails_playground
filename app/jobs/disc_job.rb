require 'disc'
require 'mail'

class DiscJob
  include Disc::Job
  disc queue: "urgent"

  def perform(*args)
    STDOUT.puts args.inspect
    process_id = Process.pid
    thread_id = Thread.current.object_id
    STDOUT.puts "rocess #{process_id}; thread #{thread_id}"
    Mail.deliver do
      from     'mzemel@sweetspotdiabetes.com'
      to       'michael.zemel@gmail.com'
      subject  'Test email'
      body     'hi'
      add_file '/Users/mzemel/Desktop/face.png'
    end
  end
end