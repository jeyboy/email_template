require "email_template/version"

module EmailTemplate
  mattr_accessor :columns_black_list
  @@columns_black_list = []

  mattr_accessor :attributes_black_list
  @@attributes_black_list = []

  class MailTemplate < ActiveRecord::Base
    include ActionView::Helpers::SanitizeHelper
    attr_accessor :prepared

    attr_accessible :name, :body, :subject, :classes
    serialize :classes, Array

    validates :name, :uniqueness => true

    def prepare(attrs={})
      @prepared ||= lambda{ |attrs|
        attrs.stringify_keys!
        body.gsub(/\#{.*?}/) do |match|
          elem, action = match[2..-2].split('.')
          attrs[elem].try(action.to_sym) rescue match.to_s
        end
      }.call(attrs)
    end

    def as_html(attrs={})
      prepare(attrs)
    end

    def as_text(attrs={})
      strip_tags(prepare(attrs))
    end

    def prepare_fields
      possible_attrs = []
      self.classes.each do |resource_class|
        current_class = resource_class.downcase.match(/\w*/mix).to_a.first
        if (current_class[0] == '_')
          possible_attrs << obj(current_class.from(1))
        else
          const_obj = current_class.camelize.constantize

          possible_attrs += const_obj.attributes.map(&:first).map { |resource_column| obj(current_class, resource_column)} if
              const_obj.respond_to?(:attributes)
          const_obj.columns.each { |resource_column| (possible_attrs << obj(current_class, resource_column.name)) unless resource_column.name =~ /#{column_pattern}/ } if
              const_obj.respond_to?(:columns)
          const_obj.public_instance_methods.select { |m_alias| (possible_attrs << obj(current_class, m_alias.to_s.from(3))) if m_alias.to_s.start_with?("___") }
        end
      end
      possible_attrs.uniq
    end

  private
    def column_pattern
      @column_pattern ||= "(" + columns_black_list.join(")|(") + ")"
    end

    def attr_pattern
      @attr_pattern ||= "(" + attributes_black_list.join(")|(") + ")"
    end

    def obj(clas, name = "")
      "\#{#{[clas, name].join('.')}}"
    end
  end
end
