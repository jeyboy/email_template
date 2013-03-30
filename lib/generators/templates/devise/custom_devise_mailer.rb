require 'email_template/linkable/devise'
include EmailTemplate::Linkable::DeviseMailer

class CustomDeviseMailer < DeviseTemplateSendMailer
  def confirmation_instructions(record, opts={})
    sending(record, :confirmation_instructions,
            "#{obj_class_name(record)}_mailer:#{__method__}", opts, {})
  end

  def reset_password_instructions(record, opts={})
    sending(record, :reset_password_instructions,
            "#{obj_class_name(record)}_mailer:#{__method__}", opts, {})
  end

  def unlock_instructions(record, opts={})
    sending(record, :unlock_instructions,
            "#{obj_class_name(record)}_mailer:#{__method__}", opts, {})
  end
end