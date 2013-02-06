module Linkable
  module DeviseMailerHelper
    def link_head(record)
      "#{ActionMailer::Base.default_url_options[:host]}/#{record.class.name.tableize.singularize}"
    end

    def sending(record, action, template_name, opts)
      send_mail(record, action, template_name, opts,
                {record_name(record).to_sym => record})
    end

    def record_name(record)
      record.class.name.tableize.singularize
    end
  end
end