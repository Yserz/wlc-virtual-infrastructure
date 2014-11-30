


class Hardware
  @os
  attr_accessor :processing_units
  @processing_units
  attr_accessor :memory_mb
  @memory_mb
  
  def initialize(processing_units=4, memory_mb=4096)
	@processing_units = processing_units
	@memory_mb = memory_mb

    @os = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if @os =~ /darwin/
      @processing_units = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      @memory_mb = `sysctl -n hw.memsize`.to_i / 1024 / 1024
    elsif @os =~ /linux/
      @processing_units = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      @memory_mb = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
    elsif @os =~ /mswin|cygwin|mingw/ 
	  # Needs Admin permissions, Vista+ only
      @memory_mb = `wmic OS get TotalVisibleMemorySize /Value`.gsub("TotalVisibleMemorySize=","").to_i / 1024
      @processing_units = `wmic cpu get NumberOfLogicalProcessors`.gsub("NumberOfLogicalProcessors","").to_i
    end
  end
end