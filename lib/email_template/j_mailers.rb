module JMailers
  class TemplateSendMailer < ActionMailer::Base
    def send_mail(template_name, to, params = {})
      check_template(template_name)
      mailing(to, params)
    end

    protected
    def check_template(template_name)
      throw "#{template_name} not set" if (@template = MailTemplate.where(name: template_name).first).blank?
    end

    def mailing(email, attrs={})
      mail to: email, subject: @template.subject do |format|
        format.text { render :text => @template.as_text(attrs) }
        format.html { render :text => @template.as_html(attrs) }
      end
    end
  end
end