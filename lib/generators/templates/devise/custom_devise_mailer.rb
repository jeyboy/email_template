require "email_template/linkable/devise"
include Linkable::DeviseMailer

class CustomDeviseMailer < DeviseTemplateSendMailer
  def confirmation_instructions(record, opts={})
    send_mail(record, :confirmation_instructions, "#{record_name(record)}_mailer:#{__method__}", opts.merge(record_name.to_sym => record))
  end

  def reset_password_instructions(record, opts={})
    send_mail(record, :reset_password_instructions, "#{record_name(record)}_mailer:#{__method__}", opts.merge(record_name.to_sym => record))
  end

  def unlock_instructions(record, opts={})
    send_mail(record, :unlock_instructions, "#{record_name(record)}_mailer:#{__method__}", opts.merge(record_name.to_sym => record))
  end

  private
  def record_name(record)
    record.class.name.tableize.singularize
  end
end