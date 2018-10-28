class Mode
  include SuckerPunch::Job
  workers 1
  SuckerPunch.shutdown_timeout = 4
end
