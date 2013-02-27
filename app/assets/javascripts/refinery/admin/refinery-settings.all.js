// Source: src/refinery-settings/scripts/admin/new_setting_form.js
    /**
     * @constructor
     * @class refinery.admin.NewSettingForm
     * @extends {refinery.Object}
     */
    refinery.Object.create({

        name: 'NewSettingForm',

        module: 'admin',

        objectMethods: {
            toUserInterface: function (holder) {
                var setting_form = holder.find('#new_setting');

                if (setting_form.length > 0) {
                    refinery.n('admin.NewSettingForm').init(setting_form);
                }
            }
        },

        /**
         * Switch setting type between boolean and text
         *
         * @param {string} type
         *
         * @return {undefined}
         */
        enable_value_type: function (type) {
            var holder = this.holder.find('#holder-' + type);
            var fields = this.holder.find('.value-field').not(holder);
            fields.find('input, textarea, select').prop('disabled', true);
            holder.find('input, textarea, select').prop('disabled', false);
            fields.hide();
            holder.show();
        },

        /**
         * Initialisation
         *
         * @param {!jQuery} holder
         *
         * @return {Object} self
         */
        init: function (holder) {
            var that = this,
                input_value_type = holder.find('#setting_form_value_type');

            if (this.is('initialisable')) {
                that.is('initialising', true);
                that.holder = holder;
                that.enable_value_type(input_value_type.find('option:selected').val());

                input_value_type.on('change', function () {
                    that.enable_value_type(input_value_type.find('option:selected').val());
                });

                this.is({'initialised': true, 'initialising': false});
                this.trigger('init');
            }

            return this;
        }
    });
// Source: src/refinery-settings/scripts/admin/dialogs/settings_dialog.js
    /**
     * @constructor
     * @class refinery.admin.SettingsDialog
     * @extends {refinery.admin.Dialog}
     * @param {Object=} options
     */
    refinery.Object.create({
        objectPrototype: refinery.n('admin.Dialog', {
            title: t('refinery.admin.settings_dialog_title'),
            url: '/refinery/dialogs/settings'
        }, true),

        name: 'SettingsDialog'
    });