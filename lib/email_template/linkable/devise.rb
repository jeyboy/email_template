module EmailTemplate
  module Linkable
    module DeviseMailer
      class DeviseTemplateSendMailer < Devise::Mailer
        require "email_template/linkable/devise_helper"
        include EmailTemplate::Linkable::DeviseMailerHelper
        include ActionView::Helpers::UrlHelper
        include Devise::Mailers::Helpers

        def send_mail(record, action, template_name, mail_params = {}, template_params = {})
          initialize_from_record(record)
          opts = template_params[:*] || {}

          template_params.reverse_merge!(
            :confirm_link => link_to(opts[:confirm_name] || 'Confirm my account',
              "#{link_head(record)}/confirmation?confirmation_token=#{@resource.confirmation_token}")
          ) if @resource.respond_to? :confirmation_token

          template_params.reverse_merge!(
            :edit_password_link => link_to(opts[:change_name] || 'Change my password',
              "#{link_head(record)}/password/edit?reset_password_token=#{@resource.reset_password_token}")
          ) if @resource.respond_to? :reset_password_token

          template_params.reverse_merge!(
            :unlock_link => link_to(opts[:unlock_name] || 'Unlock my account',
              "#{link_head(record)}/unlock?unlock_token => #{@resource.unlock_token}")
          ) if @resource.respond_to? :unlock_token

          mailing(
              check_template(template_name),
              headers_for(action, mail_params).except(:subject, :template_path, :template_name),
              template_params.except(:*)
          )
        end
      end
    end
  end
end