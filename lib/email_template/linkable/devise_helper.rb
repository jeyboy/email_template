module Linkable
  module DeviseMailerHelper
    def link_head(record)
      "#{ActionMailer::Base.default_url_options[:host]}/#{record.class.name.tableize.singularize}"
    end

    def sending(record, action, template_name, opts)
      send_mail(record, action, template_name, opts,
                {obj_class_name(record).to_sym => record})
    end
  end
end