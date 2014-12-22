module NotableWeb
  class Engine < ::Rails::Engine
    isolate_namespace NotableWeb

    initializer "notable_web" do |app|
      NotableWeb.time_zone ||= Time.zone
    end
  end
end
