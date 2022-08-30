# frozen_string_literal: true

require 'rubygems'
require 'bunny'

$stdout.sync = true

conn = Bunny.new
# (host:  'localhost',
# port:  '5672',
# vhost: '/',
# user:  'guest',
# pass:  'guest')
conn.start

ch = conn.create_channel
q  = ch.queue('bunny.examples.hello_world', auto_delete: true)
x  = ch.default_exchange

q.subscribe do |_delivery_info, _metadata, payload|
  puts "Received #{payload}"
end

x.publish('Hello!', routing_key: q.name)
puts "Routing_key: #{q.name}"
sleep 1.0
conn.close
