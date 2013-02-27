require 'refinerycms-core'

module Refinery
  autoload :SettingsGenerator, 'generators/refinery/settings_generator'

  module Settings

    require 'refinery/settings/engine'
    require 'refinery/settings/configuration'

    autoload :Validators, 'refinery/settings/validators'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end
  end
end
