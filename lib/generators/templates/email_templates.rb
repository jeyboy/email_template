EmailTemplate.setup do |config|

  #############Whitelists################

  # Accepts args as Hash and as Array

  # Ignore token list for columns
  #config.columns_black_list = ["t", "i", "k"]
  #config.columns_black_list = {'*' => ["t", "i", "k"], "some_object" => ["j"]}

  # Ignore token list for attributes
  #config.attributes_black_list = []

  #######################################

  # Method header for object methods selecting. By default eql "et_"
  #config.methods_header = "et_"
end
