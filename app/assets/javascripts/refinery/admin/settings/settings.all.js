
(function (window, $) {

// Source: scripts/admin/new_setting_form.js
(function () {

    /**
     * @constructor
     * @class refinery.admin.settings.NewSettingForm
     * @extends {refinery.Object}
     */
    refinery.Object.create({

        name: 'NewSettingForm',

        module: 'admin.settings',

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

            if (that.is('initialisable')) {
                that.is('initialising', true);
                that.holder = holder;
                that.enable_value_type(input_value_type.find('option:selected').val());

                input_value_type.on('change', function () {
                    that.enable_value_type(input_value_type.find('option:selected').val());
                });

                that.is({'initialised': true, 'initialising': false});
                that.trigger('init');
            }

            return that;
        }
    });

    /**
     * Form initialization
     *
     * @expose
     * @param  {jQuery} holder
     * @return {undefined}
     */
    refinery.admin.ui.settingsNewSettingForm = function (holder, ui) {
        holder.find('#new_setting').each(function () {
            ui.addObject(
                refinery('admin.settings.NewSettingForm').init($(this))
            );
        });
    };

}());

// Source: scripts/admin/dialogs/settings_dialog.js
(function (refinery) {

    /**
     * @constructor
     * @extends {refinery.admin.Dialog}
     * @param {Object=} options
     * @return {refinery.admin.settings.SettingsDialog}
     */
    refinery.Object.create({
        objectPrototype: refinery('admin.Dialog', {
            title: t('refinery.admin.settings_dialog_title'),
            url_path: '/dialogs/settings'
        }, true),

        name: 'SettingsDialog',

        module: 'admin.settings'
    });

}(refinery));
}(window, jQuery));