require "email-template/version"
require "email_template/j_models"
require "email_template/j_mailers"

module EmailTemplate
  include JModels

  mattr_accessor :columns_black_list
  @@columns_black_list = []

  mattr_accessor :attributes_black_list
  @@attributes_black_list = []

  def self.setup
    yield self
  end
end
