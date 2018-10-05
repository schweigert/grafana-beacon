require 'gbeacon/version'
require 'graphite-api'
require 'usagewatch_ext'

module Gbeacon
  class Beacon
    def initialize graphite:'tcp://localhost:2003', prefix: ['default', 'beacon'], slice: 60, interval: 60, cache: 60 * 60 * 24
      @client = GraphiteAPI.new(graphite: graphite, prefix: prefix, slice: slice, interval: interval, cache: cache)
    end

    def send_resources
      @client.metrics(build_resources, Time.now)
    end

    def check!
      @client.check!
    end

    private

    def build_resources
      {
        'uw_diskused' => Usagewatch.uw_diskused,
        'uw_diskused_perc' => Usagewatch.uw_diskused_perc,
        'uw_cpuused' => Usagewatch.uw_cpuused,
        'uw_tcpused' => Usagewatch.uw_tcpused,
        'uw_udpused' => Usagewatch.uw_udpused,
        'uw_memused' => Usagewatch.uw_memused,
        'uw_load' => Usagewatch.uw_load,
        'uw_bandrx' => Usagewatch.uw_bandrx,
        'uw_bandtx' => Usagewatch.uw_bandtx,
        'uw_diskioreads' => Usagewatch.uw_diskioreads,
        'uw_diskiowrites' => Usagewatch.uw_diskiowrites,
        'uw_cputop' => Usagewatch.uw_cputop,
        'uw_memtop' => Usagewatch.uw_memtop,
        'uw_httpconns' => Usagewatch.uw_httpconns
      }
    end
  end
end
