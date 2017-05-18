defmodule HelloNerves.Application do
  use Application

  require Logger

  @interface :wlan0
  @kernel_modules Mix.Project.config[:kernel_modules] || []

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Task, [fn -> init_kernel_modules() end], restart: :transient, id: Nerves.Init.KernelModules),
      worker(Task, [fn -> init_network() end], restart: :transient, id: Nerves.Init.Network),
      worker(HelloNerves.Blinker, [])
      # worker(HelloNerves.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloNerves.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def init_kernel_modules() do
    Enum.each(@kernel_modules, & System.cmd("modprobe", [&1]))
  end

  def init_network() do
    opts = Application.get_env(:hello_nerves, @interface)
    Nerves.InterimWiFi.setup(@interface, opts)
  end
end
