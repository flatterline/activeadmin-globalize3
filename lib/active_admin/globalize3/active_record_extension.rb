module ActiveAdmin::Globalize3
  module ActiveRecordExtension

    module Methods
      def translation_names
        self.translations.map(&:locale).map do |locale|
          I18n.t("active_admin.globalize3.language.#{locale}")
        end.uniq.sort
      end
    end

    def active_admin_translates(*args, &block)
      translates(*args.dup)
      args.extract_options!

      if block
        translation_class.instance_eval &block
      end

      unless Rails::VERSION::MAJOR > 3 && !defined? ProtectedAttributes
        translation_class.attr_accessible :locale
        translation_class.attr_accessible *args

        attr_accessible :translations_attributes
      end

      accepts_nested_attributes_for :translations, allow_destroy: true

      include Methods
    end

  end
end

