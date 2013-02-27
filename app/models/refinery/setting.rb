module Refinery
  class Setting < Refinery::Core::BaseModel
    extend FriendlyId
    friendly_id :name, use: :slugged

    include Settings::Validators

    DEFAULT_VALUE_TYPE = 'text_area'
    BOOLEAN_VALUE_TYPE = 'check_box'

    FORM_VALUE_TYPES = [
      ['Multi-line', DEFAULT_VALUE_TYPE],
      ['Checkbox', BOOLEAN_VALUE_TYPE]
    ]

    validates :name, presence: true
    validates_with SettingNameUniquenessValidator, on: :create

    serialize :value # stores into YAML format

    class << self

      # find_or_set offers a convenient way to
      def find_or_set(name, the_value, options={})
        # Merge default options with supplied options.
        options = {
          scoping: nil,
          restricted: false,
          form_value_type: DEFAULT_VALUE_TYPE
        }.merge(options)

        # try to find the setting first
        value = get(name, scoping: options[:scoping])

        # if the setting's value is nil, store a new one using the existing functionality.
        value = set(name, options.merge({value: the_value})) if value.nil?

        # Return what we found.
        value
      end

      alias :get_or_set :find_or_set

      # Retrieve the current value for the setting whose name is supplied.
      def get(name, options = {})
        record = find_by({ name: name, scoping: nil }.update(options))
        record.value if record
      end

      alias :[] :get

      def set(name, value)
        scoping = (value[:scoping] if value.is_a?(Hash) && value.has_key?(:scoping))
        setting = where(name: name.to_s, scoping: scoping).first_or_initialize

        # you could also pass in {value: 'something', scoping: 'somewhere'}
        if value.is_a?(Hash)
          setting.assign_attributes(value)
        else
          setting.value = value
        end

        # Save because we're in a setter method.
        setting.save

        # Return the value
        setting.value
      end
    end

    # prettier version of the name.
    # site_name becomes Site Name
    def title
      result = name.to_s.titleize
      result << " (#{scoping.titleize})" if scoping.is_a?(String)
      result
    end

    # form_value is so that on the web interface we can display a sane value.
    def form_value
      unless self[:value].blank? or self[:value].is_a?(String)
        YAML::dump(self[:value])
      else
        self[:value]
      end
    end

    def value
      replacements!(self[:value])
    end

    private

    # This code maps the two boolean values
    # correctly so that a boolean is returned instead of a string.
    REPLACEMENTS = {'true' => true, 'false' => false, '1' => true, '0' => false}

    def replacements!(current_value)
      if form_value_type == BOOLEAN_VALUE_TYPE
        # This bit handles true and false so that true and false
        # are actually returned not '0' or '1'
        current_value = REPLACEMENTS[current_value.to_s]
      else
        # converts the serialised value back to an integer
        # if the value is an integer
        if current_value.respond_to?(:to_i) &&
          current_value.to_i.to_s == current_value
            current_value = current_value.to_i
        end
      end

      current_value
    end

  end
end
