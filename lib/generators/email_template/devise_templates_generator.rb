module EmailTemplate
  module Generators
    class DeviseTemplatesGenerator < Rails::Generators::NamedBase
      attr_reader :bodies

      desc 'Create devise basic templates for input scope'
      def initialize(args, *options)
        super
        @bodies = {}
        @bodies['confirmation_instructions'] = <<-STR
                              <p>Welcome \#{#{name}.email}!</p>
                              <p>You can confirm your account email through the link below:</p>
                              <p>\#{confirm_link}</p>
                            STR
        @bodies['reset_password_instructions'] = <<-STR
                              <p>Hello \#{#{name}.email}!</p>
                              <p>Someone has requested a link to change your password. You can do this through the link below.</p>
                              <p>\#{edit_password_link}</p>
                              <p>If you didn't request this, please ignore this email.</p>
                              <p>Your password won't change until you access the link above and create a new one.</p>
                            STR
        @bodies['unlock_instructions'] = <<-STR
                              <p>Hello \#{#{name}.email}!</p>
                              <p>Your account has been locked due to an excessive amount of unsuccessful sign in attempts.</p>
                              <p>Click the link below to unlock your account:<\p>
                              <p>\#{unlock_link}</p>
                            STR

        generate_templates
      end

      def generate_templates
        if defined?(MailTemplate)
          ['confirmation_instructions', 'reset_password_instructions', 'unlock_instructions'].each do |method_name|
            template_name = "#{name}_mailer:#{method_name}"

            if MailTemplate.where(:name => template_name).empty?
              STDOUT << template_name << "\n"
              MailTemplate.create do |new_template|
                new_template.name = template_name
                new_template.classes = []
                new_template.subject = method_name.humanize
                new_template.body = bodies[method_name]
              end
            end
          end
        else
          STDOUT << "base model \"MailTemplate\" missed"
        end
      end
    end
  end
end