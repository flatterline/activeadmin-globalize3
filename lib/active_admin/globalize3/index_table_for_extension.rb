require 'active_admin/views/components/status_tag'

module ActiveAdmin
  module Globalize3
    module IndexTableFor
      def translation_status
        column I18n.t("active_admin.globalize3.translations") do |obj|
          obj.translations.order(:locale).map do |t|
            if obj.translated_attribute_names.all? { |n| t.send(n).blank? }
              "<span class='status_tag error' title='#{I18n.t("active_admin.globalize3.status.none")}'>#{I18n.t("active_admin.globalize3.language.#{t.locale}")}</span>"
            elsif obj.translated_attribute_names.any? { |n| t.send(n).blank? }
              "<span class='status_tag warning' title='#{I18n.t("active_admin.globalize3.status.partial")}'>#{I18n.t("active_admin.globalize3.language.#{t.locale}")}</span>"
            else
              "<span class='status_tag ok' title='#{I18n.t("active_admin.globalize3.status.full")}'>#{I18n.t("active_admin.globalize3.language.#{t.locale}")}</span>"
            end
          end.join(" ").html_safe
        end
      end
    end
  end
end

