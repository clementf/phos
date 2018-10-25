web: rackup -p ${PORT:-3000} -o ${BIND:-0.0.0.0}
scheduler: bundle exec clockwork lib/scheduler.rb
leds: python -u lib/leds/leds_listener.py
