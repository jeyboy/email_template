# EmailTemplate

TODO: Write a gem description

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

Config token lists in 
    config/initializers/email_template.rb

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

    class ActivityPartnerMailer < JMailers::TemplateSendMailer
      def join_confirmation_self(activity_partner)
        #send_mail(template_name, mails, classes_params_hash)
        send_mail("activity_partner_mailer:#{__method__}", "info@petitevillage.com", :activity_partner => activity_partner)
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
