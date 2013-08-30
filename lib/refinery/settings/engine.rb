module Refinery
  module Settings
    class Engine < ::Rails::Engine
      extend Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_settings

      config.autoload_paths += %W( #{config.root}/lib )

      initializer "register refinery settings plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'settings'
          plugin.position = 10000 # put settings plugin at end
          plugin.hide_from_menu = !Refinery::Settings.enable_interface
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.admin_settings_path }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Settings)
        # if you need debug js change .min to .all
        Refinery::Core.config.register_admin_javascript('refinery/admin/refinery-settings.min')
      end
    end
  end
end
