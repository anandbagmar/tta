#require 'cukeforker'
#
#module CukeForker
#  class LoggingListener < AbstractListener
#    def on_run_finished(failed)
#      log.info "[    run           ] finished, #{status_string failed}"
#      exit 1 if failed
#    end
#  end
#end