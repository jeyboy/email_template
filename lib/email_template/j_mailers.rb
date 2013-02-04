module JMailers
  class TemplateSendMailer < ActionMailer::Base
    include JModels

    def send_mail(template_name, mail_params = {}, template_params = {})
      check_template(template_name)
      mailing(mail_params, template_params)
    end

    protected
    def check_template(template_name)
      throw "#{template_name} not set" if (@template = MailTemplate.where(name: template_name).first).blank?
    end

    def mailing(mail_params = {}, template_params = {})
      mail_params.reverse_merge!(subject: @template.subject)

      if mail_params.has_key?(:template_path) && mail_params.has_key?(:template_name)
        mail mail_params
      else
        mail mail_params do |format|
          format.text { render :text => @template.as_text(template_params) }
          format.html { render :text => @template.as_html(template_params) }
        end
      end
    end
  end
end