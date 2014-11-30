

class Browser
  @os
  @command
  
  def initialize
    @os = RbConfig::CONFIG['host_os']
    @command = ""
    
    if @os =~ /darwin/
      @command = "open"
    elsif @os =~ /linux/
      @command = "xdg-open"
    elsif @os =~ /cygwin/
      @command = "cygstart"
    elsif @os =~ /mingw|mswin/
      @command = "start"
    end
  end
  
  def open(url)
    success = system("#{@command} #{url}") unless @command == ""
  end
  
end