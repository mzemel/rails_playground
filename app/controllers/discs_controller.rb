require_relative '../../lib/async_log/async_log.rb'

class AsyncError < StandardError
  def message
    "This error will be published asynchronously"
  end
end

class SyncError < StandardError
  def message
    "This error will be published synchronously"
  end
end

class DiscsController < ApplicationController
  def send_delayed_job
    STDOUT.puts "Through ActiveJob"
    # DiscActiveJob.perform_later
    DiscActiveJob.new.perform
    STDOUT.puts "Through Disc"
    DiscJob.enqueue("random_argument")
    render text: "OK"
  end

  def generate_errors
    send_sync_error_through_active_job
    send_sync_error_through_disc_gem
    send_async_error_through_async_log
    send_delayed_job_to_test_default_queue
    render text: "OK"
  end

  def send_sync_error_through_active_job
    raise SyncError.new
  rescue StandardError => e
    ErrorPusherJob.new.perform(e)
  end

  def send_sync_error_through_disc_gem
    process_id = Process.pid
    thread_id = Thread.current.object_id
    STDOUT.puts "Process #{process_id}; thread #{thread_id}"
    raise SyncError.new
  rescue StandardError => e
    DiscJob.enqueue
  end

  def send_async_error_through_async_log
    raise AsyncError.new
  rescue StandardError => e
    Mitosis.log(e, Rails.env)
  end

  def send_delayed_job_to_test_default_queue
    DiscActiveJob.perform_later
  end
end