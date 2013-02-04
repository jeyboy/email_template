require "email_template/j_models"
require "email_template/j_mailers"
require "email_template/j_helpers"

include JModels
include JMailers
include EmailTemplate::Mailers::Helpers

module EmailTemplate
  #
  #module Mailers
  #  autoload :Helpers, 'email_template/mailers/email_template/helpers/helpers'
  #end

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
