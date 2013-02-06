require "email_template/linkable/devise"
include Linkable::DeviseMailer

class CustomDeviseMailer < DeviseTemplateSendMailer
  def confirmation_instructions(record, opts={})
    record_name = record.class.name.tableize.singularize
    send_mail(record, :confirmation_instructions, "#{record_name}_mailer:#{__method__}", opts.merge(record_name.to_sym => record))
  end

  def reset_password_instructions(record, opts={})
    record_name = record.class.name.tableize.singularize
    send_mail(record, :reset_password_instructions, "#{record_name}_mailer:#{__method__}", opts.merge(record_name.to_sym => record))
  end

  def unlock_instructions(record, opts={})
    record_name = record.class.name.tableize.singularize
    send_mail(record, :unlock_instructions, "#{record_name}_mailer:#{__method__}", opts.merge(record_name.to_sym => record))
  end
end