module Linkable
  module DeviseMailerHelper
    def link_head(record)
      "#{ActionMailer::Base.default_url_options[:host]}/#{record.class.name.tableize.singularize}"
    end

    def sending(record, action, template_name, email_opts = {}, template_opts = {})
      send_mail(record, action, template_name, email_opts,
                template_opts.merge(obj_class_name(record).to_sym => record))
    end
  end
end