module EmailTemplate
  module Generators
    class DeviseGenerateTemplatesGenerator < Rails::Generators::NamedBase
      desc "Create devise basic templates for input scope."
      def initialize(args, *options)
        super
        #generate_templates
      end

      def generate_templates
        #if defined?(MailTemplate)
        #  ['confirmation_token']
        #else
        #  STDOUT << "base model \"MailTemplate\" missed"
        #end
      end
    end
  end
end
