# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"

config :nerves, :firmware, rootfs_additions: "config/rootfs-additions"

config :hello_nerves, :led_pin, 23

config :hello_nerves, :wlan0,
  ssid: "El Cowork 2.4GHz (2)",
  key_mgmt: :"WPA-PSK", # :NONE if no password
  psk: "huskysea179"
