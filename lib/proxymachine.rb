require 'rubygems'
require 'eventmachine'

require 'proxymachine/client_connection'
require 'proxymachine/server_connection'

class ProxyMachine
  def self.log(str)
    puts str if false
  end

  def self.incr
    @@counter ||= 0
    @@counter += 1
    log @@counter
  end

  def self.decr
    @@counter ||= 0
    @@counter -= 1
    log @@counter
  end

  def self.set_router(block)
    @@router = block
  end

  def self.router
    @@router
  end

  def self.run(host, port)
    EM.epoll

    EM.run do
      EventMachine::Protocols::ClientConnection.start(host, port)
    end
  end
end

module Kernel
  def proxy(&block)
    ProxyMachine.set_router(block)
  end
end