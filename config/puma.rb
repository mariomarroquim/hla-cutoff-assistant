environment 'production'
port 3000
preload_app!
rackup 'config.ru'
threads 1, 4
workers 2
