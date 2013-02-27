module EmailTemplate
  module JMailers
    class TemplateSendMailer < ActionMailer::Base
      def send_mail(template_name, mail_params = {}, template_params = {})
        mailing(check_template(template_name), mail_params, template_params)
      end
    end
  end
end