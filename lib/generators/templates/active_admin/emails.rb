ActiveAdmin.register EmailTemplate do
  config.sort_order = "name_asc"

  filter :subject, as: :select, collection: proc { EmailTemplate.all.map(&:subject) }

  actions :all, :except => [:destroy, :new]

  index as: :grid do |email_template|
    a email_template.name.humanize, href: admin_email_template_path(email_template)
  end

  show do
    attributes_table do
      row :subject
      row :body
    end
  end

  sidebar :email_objects, :only => :edit do
    raw([
        "You may use next constants :",
        "<br/><br/>",
        ("<div>#{resource.prepare_fields.join("</div><div>")}</div>")
        ].join)
  end

  form do |f|
    f.inputs do
      f.input :subject
      f.input :body, :as => :rich
    end
    f.actions
  end
end
