workers 2
threads 8, 10

preload_app!

bind 'unix:///var/run/app-socket/rails-app.sock'

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
