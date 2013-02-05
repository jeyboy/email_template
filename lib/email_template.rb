require "email_template/j_models"
require "email_template/j_mailers"
require "email_template/j_helpers"

include JModels
include JMailers
include EmailTemplate::Mailers::Helpers

module EmailTemplate
  mattr_accessor :columns_black_list
  self.columns_black_list = []
  mattr_accessor :attributes_black_list
  self.attributes_black_list = []
  mattr_accessor :methods_header
  self.methods_header = "et_"

  def self.setup
    yield self
  end
end
