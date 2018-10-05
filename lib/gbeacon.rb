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
        'uw_httpconns' => Usagewatch.uw_httpconns,
        'total_memory_linux_monitor' => total_memory_linux_monitor,
        'used_memory_linux_monitor' => used_memory_linux_monitor,
        'total_swap_linux_monitor' => total_swap_linux_monitor,
        'used_swap_linux_monitor' => used_swap_linux_monitor,
        'free_memory_linux_monitor' => free_memory_linux_monitor,
        'free_swap_linux_monitor' => free_swap_linux_monitor
      }
    end

    def total_memory_linux_monitor
      free_mem.split("\n")[1].split(" ")[1]
    rescue
      '0'
    end

    def total_swap_linux_monitor
      free_mem.split("\n")[2].split(" ")[1]
    rescue
      '0'
    end

    def used_memory_linux_monitor
      free_mem.split("\n")[1].split(" ")[2]
    rescue
      '0'
    end

    def used_swap_linux_monitor
      free_mem.split("\n")[2].split(" ")[2]
    rescue
      '0'
    end

    def free_memory_linux_monitor
      free_mem.split("\n")[1].split(" ")[3]
    rescue
      '0'
    end

    def free_swap_linux_monitor
      free_mem.split("\n")[2].split(" ")[3]
    rescue
      '0'
    end

    def free_mem
      `free -m`
    end
  end
end
