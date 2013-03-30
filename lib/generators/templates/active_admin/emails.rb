ActiveAdmin.register MailTemplate, :as => 'Mail Template' do
  config.sort_order = 'name_asc'
  config.batch_actions = false #comment this if you need batches

  filter :subject, as: :select, collection: proc { MailTemplate.all.map(&:subject) }

  actions :all, :except => [:destroy, :new]

  index as: :grid do |email_template|
    a email_template.name.humanize, href: admin_mail_template_path(email_template)
  end

  show do |email_template|
    attributes_table do
      row :subject
      row :body do
        raw email_template.body
      end
    end
  end

  sidebar :email_objects, :only => :edit do
    raw([
        'You may use next constants :',
        '<br/><br/>',
        ("<div>#{resource.prepare_fields.join("</div><div>")}</div>")
        ].join)
  end

  form do |f|
    f.inputs do
      f.input :subject
      f.input :body  #, :as => :rich  # You may use this flag if you have installed gem 'rich'
    end
    f.actions
  end
end
