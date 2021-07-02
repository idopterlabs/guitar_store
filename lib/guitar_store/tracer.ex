defmodule GuitarStore.Tracer do
  use Spandex.Tracer, otp_app: :guitar_store

  defmodule ModuleTracer do
    defmacro __using__(_opts) do
      quote do
        use Spandex.Decorators

        @decorate_all span()
      end
    end
  end
end
