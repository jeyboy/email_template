class AddMailsTemplate < ActiveRecord::Migration
  def self.up
    create_table :email_templates do |t|
      t.string :name
      t.string :subject
      t.text :body
      t.text :classes

      t.datetime :created_at
    end
  end

  def self.down
    drop_table :email_templates
  end
end
