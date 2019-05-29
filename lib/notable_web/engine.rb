module NotableWeb
  class Engine < ::Rails::Engine
    isolate_namespace NotableWeb

    initializer "notable_web" do |app|
      # use a proc instead of a string
      app.config.assets.precompile << proc { |path| path == "notable_web.js" }

      NotableWeb.time_zone ||= Time.zone
    end
  end
end
