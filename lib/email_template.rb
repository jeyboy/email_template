require "email_template/version"

module EmailTemplate
  mattr_accessor :columns_black_list
  @@columns_black_list = []

  mattr_accessor :attributes_black_list
  @@attributes_black_list = []

  def self.setup
    yield self
  end
end
