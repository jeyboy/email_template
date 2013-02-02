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
    def finder(classname, items, val, current_pattern)
      items.each_with_object([]) do |attr, ret|
        (ret << obj(classname, attr.send(val))) if ((attr.send(val) =~ /#{current_pattern}/).nil? || current_pattern.nil?)
      end
    end

    def find_attributes(classname, object)
      if object.respond_to?(:attributes)
        finder(classname, object.attributes, :first, attr_pattern(classname))
      end || []
    end

    def find_columns(classname, object)
      if object.respond_to?(:columns)
        finder(classname, object.columns, :name, column_pattern(classname))
      end || []
    end

    def find_methods(classname, object)
      object.public_instance_methods.each_with_object([]) do |m_alias, ret|
        (ret << obj(classname, m_alias.to_s.from(3))) if m_alias.to_s.start_with?("et_")
      end
    end

    private
    def regex_from_list(list)
      list.blank? ? nil : "(" + list.join(")|(") + ")"
    end

    def regex_from_hash(hash, object)
      regex_from_list(hash[object] || hash['*'] || [])
    end

    def pattern(elems, object)
      elems.is_a?(Array) ? regex_from_list(elems) : regex_from_hash(elems, object)
    end

    def column_pattern(object)
      pattern(columns_black_list, object)
    end

    def attr_pattern(object)
      pattern(attributes_black_list, object)
    end

    def obj(clas, name = nil)
      "\#{#{[clas, name].compact.join('.')}}"
    end
  end
end