module Byebug

  class Interface
    attr_writer :have_readline

    def initialize
      @have_readline = false
    end

    # Common routine for reporting byebug error messages.
    # Derived classes may want to override this to capture output.
    def errmsg(*args)
      print '*** '
      print(*args)
    end

    def format(*args)
      if args.is_a?(Array)
        new_args = args.first
        new_args = new_args % args[1..-1] unless args[1..-1].empty?
      else
        new_args = args
      end
      new_args
    end

    def escape(msg)
      msg.gsub('%', '%%')
    end
  end

  class LocalInterface < Interface
    attr_accessor :command_queue, :history_length, :history_save, :histfile
    attr_accessor :restart_file

    FILE_HISTORY = ".byebug_hist" unless defined?(FILE_HISTORY)

    def initialize()
      super
      @command_queue = []
      @have_readline = false
      @history_save = true
      @history_length = ENV["HISTSIZE"] ? ENV["HISTSIZE"].to_i : 256
      @histfile = File.join(ENV["HOME"]||ENV["HOMEPATH"]||".", FILE_HISTORY)
      open(@histfile, 'r') do |file|
        file.each do |line|
          line.chomp!
          Readline::HISTORY << line
        end
      end if File.exist?(@histfile)
      @restart_file = nil
    end

    def read_command(prompt)
      readline(prompt, true)
    end

    def confirm(prompt)
      readline(prompt, false)
    end

    def print(*args)
      STDOUT.printf(escape(format(*args)))
    end

    def close
    end

    # Things to do before quitting
    def finalize
      if Byebug.respond_to?(:save_history)
        Byebug.save_history
      end
    end

    def readline_support?
      @have_readline
    end

    private

      begin
        require 'readline'
        class << Byebug
          @have_readline = true
          define_method(:save_history) do
            iface = self.handler.interface
            iface.histfile ||= File.join(ENV["HOME"]||ENV["HOMEPATH"]||".",
                                    FILE_HISTORY)
            open(iface.histfile, 'w') do |file|
              Readline::HISTORY.to_a.last(iface.history_length).each do |line|
                file.puts line unless line.strip.empty?
              end if defined?(iface.history_save) and iface.history_save
            end rescue nil
          end
          public :save_history
        end

        def readline(prompt, hist)
          Readline::readline(prompt, hist)
        rescue Interrupt
          print "^C\n"
          retry
        end
      rescue LoadError
        def readline(prompt, hist)
          @histfile = ''
          @hist_save = false
          STDOUT.print prompt
          STDOUT.flush
          line = STDIN.gets
          exit unless line
          line.chomp!
          line
        end
      end
  end

  class RemoteInterface < Interface
    attr_accessor :command_queue, :history_length, :history_save, :histfile
    attr_accessor :restart_file

    def initialize(socket)
      @command_queue = []
      @socket = socket
      @history_save = false
      @history_length = 256
      @histfile = ''
      # Do we read the histfile?
#       open(@histfile, 'r') do |file|
#         file.each do |line|
#           line.chomp!
#           Readline::HISTORY << line
#         end
#       end if File.exist?(@histfile)
      @restart_file = nil
    end

    def close
      @socket.close
    rescue Exception
    end

    def confirm(prompt)
      send_command "CONFIRM #{prompt}"
    end

    def finalize
    end

    def read_command(prompt)
      send_command "PROMPT #{prompt}"
    end

    def readline_support?
      false
    end

    def print(*args)
      @socket.printf(escape(format(*args)))
    end

    private

      def send_command(msg)
        @socket.puts msg
        result = @socket.gets
        raise IOError unless result
        result.chomp
      end
  end

  class ScriptInterface < Interface
    attr_accessor :command_queue, :history_length, :history_save, :histfile
    attr_accessor :restart_file

    def initialize(file, out, verbose=false)
      super()
      @command_queue = []
      @file = file.respond_to?(:gets) ? file : open(file)
      @out = out
      @verbose = verbose
      @history_save = false
      @history_length = 256
      @histfile = ''
    end

    def finalize
    end

    def read_command(prompt)
      while result = @file.gets
        puts "# #{result}" if @verbose
        next if result =~ /^\s*#/
        next if result.strip.empty?
        break
      end
      raise IOError unless result
      result.chomp!
    end

    def readline_support?
      false
    end

    def confirm(prompt)
      'y'
    end

    def print(*args)
      @out.printf(*args)
    end

    def close
      @file.close
    end
  end
end
