module Refinery
  module Admin
    class SettingsDialogController < ::Refinery::AdminDialogController

      def index
        @setting = Refinery::Setting.find_by(id: params[:id].to_i) if params[:id].present?
        @setting = Refinery::Setting.new unless @setting
      end

    end
  end
end
