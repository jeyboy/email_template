require 'generators/email_template/install_helpers'

module EmailTemplate
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include EmailTemplate::Generators::OrmHelpers

      source_root File.expand_path("../../", __FILE__)

      desc 'Creates initializer and migration. If ActiveAdmin install - copy admin page for templates'
      class_option :orm

      def copy_initializer
        unless migration_exists?('add_mails_template')
          STDOUT << 'migration'
          template 'active_record/migration.rb', "db/migrate/#{Time.now.utc.strftime('%Y%m%d%H%M%S').to_i}_add_mails_template.rb"
        end

        STDOUT << 'config'
        template 'templates/email_templates.rb', 'config/initializers/email_template.rb'

        if Gem::Specification::find_all_by_name('activeadmin').any?
          STDOUT << 'admin'
          template 'templates/active_admin/emails.rb', 'app/admin/email_templates.rb'
        end

        if Gem::Specification::find_all_by_name('devise').any?
          STDOUT << 'devise mailer'
          template 'templates/devise/custom_devise_mailer.rb', 'app/mailers/custom_devise_mailer.rb'
        end
      end
    end
  end
end
