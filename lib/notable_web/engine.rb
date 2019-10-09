module NotableWeb
  class Engine < ::Rails::Engine
    isolate_namespace NotableWeb

    initializer "notable_web" do |app|
      if defined?(Sprockets) && Sprockets::VERSION >= "4"
        app.config.assets.precompile << "notable_web.js"
      else
        # use a proc instead of a string
        app.config.assets.precompile << proc { |path| path == "notable_web.js" }
      end

      NotableWeb.time_zone ||= Time.zone
    end
  end
end
