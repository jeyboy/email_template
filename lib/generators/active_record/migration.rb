class AddMailsTemplate < ActiveRecord::Migration
  def self.up
    create_table :mail_templates do |t|
      t.string :name
      t.string :subject
      t.text :body
      t.text :classes

      t.datetime :created_at
    end
  end

  def self.down
    drop_table :mail_templates
  end
end
