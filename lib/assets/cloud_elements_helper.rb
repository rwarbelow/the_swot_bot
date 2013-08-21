module CloudElementsHelper
  def parameterize(params)  
    URI.encode_www_form(params)
  end
end
