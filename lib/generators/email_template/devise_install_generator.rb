require 'generators/email_template/install_helpers'

module EmailTemplate
  module Generators
    class DeviseInstallGenerator < Rails::Generators::Base
      include EmailTemplate::Generators::OrmHelpers

      source_root File.expand_path("../../", __FILE__)

      desc 'Copy devise mail template'
      def copy_initializer
        STDOUT << 'devise mailer'
        template 'templates/devise/custom_devise_mailer.rb', 'app/mailers/custom_devise_mailer.rb'
      end
    end
  end
end
