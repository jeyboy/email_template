# EmailTemplate

Gem allows to develop e-mail templates with the ability of their following reduction using the tags
related to template`s objects. One of the reduction abilities is active admin.

## Installation

Add this line to your application's Gemfile:

    gem 'email_template'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email_template

## Usage

Run installer:

    $ rails g email_template:install

Run:

    $ rake db:migrate

Config common settings in 

    config/initializers/email_template.rb
    
    Settings includes next items:
        columns_black_list - present list of filters for column names of table, that linked to the object, used in template.
        
        attributes_black_list - present list of filters for object attributes.
        
        methods_header - this option is enable filter on functions of the objects that will be shown in the editor.
        That mean what if we set value 'et_' at methods_header - methods which starts with this value 
        automatically will be added to possible template list of constants.
        For example: if object have next methods or aliases: 'et_month', 'get_month', 'set_year' - 
        filter will return only 'et_month' method.

Pull template to the base :

    MailTemplate.create(name: "activity_partner_mailer:join_confirmation_self",
                        subject: "Join request confirmation",
                        classes: ["activity_partner"],
                        body:
                            <<-TEXT
                              Dear \#{activity_partner.full_name} ...
                              ....
                            TEXT
    )

In Mailer:

    class ActivityPartnerMailer < TemplateSendMailer
      def join_confirmation_self(activity_partner)
        #send_mail(template_name, mail_params = {}, template_params = {})
        send_mail("#{self.class.name.tableize.singularize}:#{__method__}", {to: "info@petitevillage.com"}, {:activity_partner_join => activity_partner})
      end
    end

## Customization

In case when you need additional customization :

In Mailer:
    
    class CustomDeviseMailer < Devise::Mailer
      include Devise::Mailers::Helpers
      include EmailTemplate::Mailers::Helpers
    
      def confirmation_instructions(record, opts={})
        @template = check_template("#{record.class.name.tableize.singularize}_mailer:#{__method__}")
        devise_mail(record, :confirmation_instructions, opts.merge(subject: @template.subject))
      end
    end    
    
In View:

    = raw(@template.as_html(:parent => @resource).gsub(/\#\{confirm_link\}/,
    link_to('Confirm my account', confirmation_url(@resource, :confirmation_token => @resource.confirmation_token))))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
