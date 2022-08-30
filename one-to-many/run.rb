# frozen_string_literal: true

require 'rubygems'
require 'bunny'

$stdout.sync = true

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.fanout('nba.scores')

ch.queue('joe', auto_delete: true).bind(x).subscribe do |_delivery_info, _metadata, payload|
  puts "#{payload} => joe"
end

ch.queue('aaron', auto_delete: true).bind(x).subscribe do |_delivery_info, _metadata, payload|
  puts "#{payload} => aaron"
end

ch.queue('bob', auto_delete: true).bind(x).subscribe do |_delivery_info, _metadata, payload|
  puts "#{payload} => bob"
end

x.publish('BOS 101, NYK 89').publish('ORL 85, ALT 88')

sleep 1.0
conn.close
