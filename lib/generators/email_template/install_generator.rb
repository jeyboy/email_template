module EmailTemplate
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../", __FILE__)

      desc "Creates initializer and migration. If ActiveAdmin install - copy admin page for templates"
      class_option :orm

      def copy_initializer
        STDOUT << "migration"
        template "active_record/migration.rb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S").to_i}_AddMailerTemplate.rb"

        STDOUT << "config"
        template "templates/email_templates.rb", "config/initializers/email_template.rb"

        if (Specification::find_by_name('activeadmin') rescue nil)
          STDOUT << "admin"
          template "templates/active_admin/emails.rb", "app/admin/emails.rb"
        end
      end

      def copy_locale;  end
    end
  end
end
