require "email-template/version"
require "email_template/j_models"
require "email_template/j_mailers"

include JModels
include JMailers

module EmailTemplate
  mattr_accessor :columns_black_list
  @@columns_black_list = []

  mattr_accessor :attributes_black_list
  @@attributes_black_list = []

  mattr_accessor :methods_header
  @@methods_header = "et_"

  def self.setup
    yield self
  end
end
