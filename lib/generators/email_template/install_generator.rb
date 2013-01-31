module EmailTemplate
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates initializer and migration. If ActiveAdmin install - copy admin page for templates"
      #class_option :orm

      def copy_initializer
        template "../active_record/migration.rb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_i}_AddMailerTemplate.rb"
        template "email_template.rb", "config/initializers/email_template.rb"
        template "active_admin/emails.rb", "app/admin/emails.rb"
      end

      def copy_locale;  end
    end
  end
end
