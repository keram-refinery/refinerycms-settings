module ::Refinery
  module Admin
    module SettingsHelper
      def form_value_type
        @setting.form_value_type.presence || Refinery::Setting::DEFAULT_VALUE_TYPE
      end

      def setting_title(f)
        if @setting.form_value_type == Refinery::Setting::BOOLEAN_VALUE_TYPE
          raw "<h3>#{@setting.name.to_s.titleize}?</h3>"
        else
          f.label :value
        end
      end

      def setting_field(f, help)
        case form_value_type
        when Refinery::Setting::BOOLEAN_VALUE_TYPE
          raw "#{f.check_box :value, :value => @setting.form_value}
               #{f.label :value, help.presence || t('enabled', :scope => 'refinery.admin.settings.form'),
                         :class => 'stripped'}"
        else
          f.text_area :value, :value => @setting.form_value, :class => 'widest', :rows => 5
        end
      end
    end
  end
end
