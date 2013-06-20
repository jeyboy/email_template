module EmailTemplate
  module Mailers
    module Helpers

    protected
      def check_template(template_name)
        if EmailTemplate.test_mode
          @template = MailTemplate.new(name: template_name, subject: template_name, body: template_name, classes: [])
        else
          throw "#{template_name} not set" if (@template = MailTemplate.where(name: template_name).first).blank?
        end

        @template
      end

      def mailing(template, mail_params = {}, template_params = {})
        mail_params.reverse_merge!(subject: template.subject)

        if mail_params.has_key?(:template_path) && mail_params.has_key?(:template_name)
          @data = template.as_html(template_params)
          mail mail_params
        else
          mail mail_params do |format|
            format.text { render :text => template.as_text(template_params) }
            format.html { render :text => template.as_html(template_params) }
          end
        end
      end

      def obj_class_name(obj)
        obj.class.name.tableize.singularize
      end


      #def subject_for(key)
      #  I18n.t(:"#{devise_mapping.name}_subject", :scope => [:devise, :mailer, key],
      #    :default => [:subject, key.to_s.humanize])
      #end
    end
  end
end
