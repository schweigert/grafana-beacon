require "gbeacon"

params = { graphite: 'tcp://localhost:2003', slice: 0, interval: 0, prefix: ['gbeacon'], cache: 0 }

if ARGV[0] == '--help'
  puts 'gbeacon.rb --graphite "tcp://local:2003" --slice 0 --interval 0 --prefix "service_name" --cache 0'
  puts 'Defaults:'
  pp params
  exit 0
end

param = :graphite

ARGV.each do |key|
  if key == '--graphite'
    param = :graphite
    next
  elsif key == '--slice'
    param = :slice
    next
  elsif key == '--interval'
    param = :interval
    next
  elsif key == '--prefix'
    param = :prefix
    next
  elsif key == '--cache'
    param = :cache
    next
  end

  if param != :prefix
    params[param] = key
  else
    params[:prefix] << key
  end
end

puts 'Starting beacon with:'

pp params
b = Gbeacon::Beacon.new(params)
b.check!

loop do
  pp b.send_resources
end
