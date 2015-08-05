require 'disque'

class ErrorPusherJob < ActiveJob::Base
  queue_as :urgent

  attr_accessor :client

  def client
    @client ||= Disque.new("127.0.0.1:7711")
  end

  def perform(exception)
    client.push("sync_queue", exception.message, 1000)
  end
end