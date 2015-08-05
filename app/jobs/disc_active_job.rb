require 'mail'

class DiscActiveJob < ActiveJob::Base
  queue_as :urgent

  def perform(*args)
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