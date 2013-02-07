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
    
For using Devise templates you need to run the following commands: 
    Install:
    
        email_template:devise_install

    The generating of common devise templates for a specified scope: 
      
    email_template:devise_templates <devise_scope>
    
    This generator produces email templates with the names:
            <devise_scope>_mailer:confirmation_instructions
            <devise_scope>_mailer:reset_password_instructions
            <devise_scope>_mailer:unlock_instructions

Run:

    $ rake db:migrate

Config common settings in 

    config/initializers/email_template.rb
    
    Settings include the following items:
        columns_black_list - the following tokens symbolize the list of filters which limits the output of
        the object table fields list as a constants list for template. 
        
        attributes_black_list - the following tokens symbolize the list of filters which limits the output
        of the object attributes list as a constants list for template
        
        Black lists accept as value the following types: array and hash. In array case filters will be applied to the all objects.
        In hash case you'll have an ability to put filters for all objects (use '*' key) and every separate object.
        For example: 
            columns_black_list = ['_at', '_id']
            columns_black_list = {'*' => ['_at', '_id'], 'user' => ['created_at']}
        
        methods_header - this option enables filter on objects functions that will be shown in the editor.
        That means what if we set value 'et_' at methods_header - methods which start with this value 
        automatically will be added to possible template list of constants.
        For example: if object has the following methods or aliases: 'et_month', 'get_month', 'set_year' - 
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

In case you need additional customization :

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
