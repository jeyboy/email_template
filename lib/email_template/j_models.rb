module JModels
  class MailTemplate < ActiveRecord::Base
    include EmailTemplate
    include ActionView::Helpers::SanitizeHelper

    self.table_name = 'email_templates'

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
          [:find_attributes, :find_columns, :find_methods].each do |method|
            possible_attrs += self.send(method, current_class, const_obj)
          end
        end
      end
      possible_attrs.uniq
    end

    protected
    def find_attributes(classname, object)
      if object.respond_to?(:attributes)
        object.attributes.map { |attr| obj(classname, attr.first)}
      end || []
    end

    def find_columns(classname, object)
      if object.respond_to?(:columns)
        object.columns.each_with_object([]) do |column, ret|
          (ret << obj(classname, column.name)) unless column.name =~ /#{column_pattern}/
        end
      end || []
    end

    def find_methods(classname, object)
      object.public_instance_methods.each_with_object([]) do |m_alias, ret|
        ( ret << obj(classname, m_alias.to_s.from(3))) if m_alias.to_s.start_with?("et_")
      end
    end

    private
    def column_pattern
      @column_pattern ||= "(" + columns_black_list.join(")|(") + ")"
    end

    def attr_pattern
      @attr_pattern ||= "(" + attributes_black_list.join(")|(") + ")"
    end

    def obj(clas, name = nil)
      "\#{#{[clas, name].compact.join('.')}}"
    end
  end
end