class DiscsController < ApplicationController
  def send_delayed_job
    STDOUT.puts "Through ActiveJob"
    DiscActiveJob.perform_later
    STDOUT.puts "Through Disc"
    DiscJob.enqueue("random_argument")
    render text: "OK"
  end
end