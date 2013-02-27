module ::Refinery
  module Admin
    class SettingsController < ::Refinery::AdminController

      helper 'refinery/admin/settings'

      crudify :'refinery/setting', order: 'name ASC'

    protected

      def find_all_settings
        @settings = ::Refinery::Setting.where(scoping: nil)

        unless current_refinery_user.has_role?(:superuser)
          @settings = @settings.where.not(restricted: true)
        end

        @settings
      end

      def find_setting
        @setting = Refinery::Setting.find_by(slug: params[:id], scoping: nil) if params[:id].friendly_id?
        @setting = Refinery::Setting.find_by(id: params[:id]) unless @setting || params[:id].friendly_id?

        @setting || error_404
      end

    private

      def setting_params
        if current_refinery_user.has_role?(:superuser)
          params.require(:setting).permit(:name, :value, :form_value_type, :restricted)
        else
          params.require(:setting).permit(:name, :value, :form_value_type)
        end
      end
    end
  end
end
