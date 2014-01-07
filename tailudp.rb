#!/usr/bin/env ruby
require 'socket'
require 'file-tail'


#create UDP socket
host = '127.0.0.1'
port = 1234
tx = UDPSocket.new
tx.connect('127.0.0.1', port)  #to send without destination address

#tail log
filename = 'collator_test.log'

File.open(filename) do |log|
   log.extend(File::Tail)
   log.interval = 10
   log.backward(20)
   tail_log = log.tail { |line| puts line }
 end


#send UDP
tx.send(tail_log, 0)

#receive UDP
rx.bind('127.0.0.1', port)

text, sender = rx.recvfrom(16)
remote_host = sender[3]
puts "#{remote_host} sent #{text}"
