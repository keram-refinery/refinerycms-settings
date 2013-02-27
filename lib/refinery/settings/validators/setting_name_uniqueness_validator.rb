module Refinery
  module Settings
    module Validators
      class SettingNameUniquenessValidator < ActiveModel::Validator

        def validate(record)
          if Setting.find_by({ name: record.name, scoping: record.scoping })
            record.errors[:name] << ::I18n.t('setting_exists',
                                             scope: 'activerecord.errors.models.refinery/setting',
                                             name: record.name)
          end
        end

      end
    end
  end
end
