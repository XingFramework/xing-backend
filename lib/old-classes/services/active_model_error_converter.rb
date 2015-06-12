class ActiveModelErrorConverter

  def initialize(am_object)
    @am_object = am_object
  end
  attr_reader :am_object

  # This is a terrible hack to preserve the semantic meaning of
  # different error types -- neccesary because ActiveModel::Errors
  # frustratingly translates semantic error messages through i18n
  # as soon as it gets them
  def json_errors
    @json_errors ||= begin
      old_locale = I18n.locale
      I18n.locale = "json"
      am_object.valid?
      error_hash = am_object.errors.to_hash.deep_dup
      I18n.locale = old_locale
      error_hash
    end
  end

  def regular_errors
    @regular_errors ||= begin
      am_object.valid?
      am_object.errors.to_hash.deep_dup
    end
  end

  def convert
    final_errors = {}
    json_errors.each_key do |key|
      final_errors[key] = {
        :type => json_errors[key][0],
        :message => regular_errors[key][0]
      }
    end
    final_errors
  end
end
