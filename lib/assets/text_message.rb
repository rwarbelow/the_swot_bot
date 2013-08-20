require "net/https"  
require "json"
  
  
class TextMessage
  
  # This method is used for finding out if the element instance is live  
  def ping  
  
    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/twilio/ping')  
  
    uri.query = parameterize(:elementToken => '00f6ea45ce42dffd5189b67800a665ac')  
  
    response, parsedResponse = invokeElement(uri)  
  
    puts "Response from ping invocation - #{response.code} #{response.message}: #{response.body}\n\n"  
  
    if parsedResponse[:success]  
  
      puts parsedResponse[:value]  
  
    else  
  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
  
    end  
  
  end  
  
  
  # This method is used for finding out the usage of the element  
  def elementsUsage  
  
    args = Hash.new  
  
    args[:elementToken] = '00f6ea45ce42dffd5189b67800a665ac'  
    #args[:days] = "10"                         # This is optional  
    #args[:startDate] = "MM-dd-yyyy HH:mm:ss"           # This is optional  
    #args[:endDate] = "MM-dd-yyyy HH:mm:ss"         # This is optional  
    #args[:aggregate] = "10"                    # This is optional  
    #args[:searchText] = "text"                 # This is optional  
  
    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/twilio/elementUsage')  
  
    uri.query = parameterize(args)  
  
    response, parsedResponse = invokeElement(uri)  
  
    puts "Response from elementUsage invocation - #{response.code} #{response.message}: #{response.body}\n\n"  
  
    if parsedResponse[:success]  
  
      puts "Number of calls to twilio messaging #{parsedResponse[:recordCount]}"  
  
      parsedResponse[:records].each do |record|  
        puts "Count: #{record[:count]}, Status: #{record[:status]}, Sent Date: #{record[:sent_date]}"  
      end  
  
    else  
  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
  
    end  
  
  end  
  
  
  # This method is used for sending messages  
  def sendMessage(hash) 
  
  
    json = Hash.new  
    message = Hash.new  
  
    #   Substitute the following  
    #message[:sender] = "Change this to sender's phone number"                  #This is optional  
    # message[:recipients] = "Change this to recipient's phone numbers"                   #This is required  
  
    #   Or you can use the below two arguments instead of the above two  
    message[:from] = "702-712-4186"  
    message[:to] = hash[:to]  
  
    message[:subject] = hash[:subject]                              #This is optional  
    message[:message] = hash[:message]                              #This is requ[:message]
    #   mimeType can be text/html or text/plain.  
    #   can be omitted. Default is text/plain.  
  
    message[:mimeType] = 'text/html'                                #This is optional  
  
    #   refId can be any tracking information that you want  
    #   generally its your reference id for this request.  
    #   Can be omitted.  
    #   Uncomment the Line below to send a reference ID.  
  
    #message[:refId] = 'Change This'                            #This is optional  
  
    #   Callback is the url that you wish to be notified at for events  
    #   associated with your message.  
    #   Uncomment the Lines below to specify a Callback URL  
  
    #message[:callback] = 'Your Call Back URL if you wish to be notified.'              #This is optional  
  
    json[:message] = message                                    #This is required  
    json[:elementToken] = '00f6ea45ce42dffd5189b67800a665ac'  
  
    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/twilio/send')  
  
    uri.query = parameterize(:elementToken => '00f6ea45ce42dffd5189b67800a665ac')  
  
    http = Net::HTTP.new(uri.host, uri.port)  
    http.use_ssl = (uri.scheme == 'https')  
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    req = Net::HTTP::Post.new(uri.request_uri)  
    req.content_type = 'application/json'  
    req.body = json.to_json  
    response = http.start {|http| http.request(req)}  
  
    parsedResponse = JSON.parse(response.body, :symbolize_names => true)  
  
    puts "Response from send invocation - #{response.code} #{response.message}: #{response.body}\n\n"  
  
    #   Checking for success in the response  
    if parsedResponse[:success]  
  
      messageId = parsedResponse[:value]  
      puts messageId  
  
      return messageId  
  
    else  
  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
  
    end  
  
  end  
  
  #   This method helps to retrieve message details for given messageId  
  def messageDetails(messageId)  
  
    args = Hash.new  
    args[:elementToken] = '00f6ea45ce42dffd5189b67800a665ac'  
    args[:messageId] = messageId                               # This is required  
  
    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/twilio/details')  
  
    uri.query = parameterize(args)  
  
    response, parsedResponse = invokeElement(uri)  
  
    puts "Response from details invocation - #{response.code} #{response.message}: #{response.body}\n\n"  
  
    if !parsedResponse[:success]  
  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
  
    end  
  
  end  
  
  
  # This method helps in searching messages based on different arguments  
  def searchMessage  
  
  
    #Substitute the following.  
    args = Hash.new  
  
    #Search based on text in messages  
    args[:text] = "Add Sample Subjects"                                 #This is optional  
  
    #Search based on refId passed while sending the messages  
    args[:refId] = ""                                           #This is optional  
  
    #Search based on startTime and endTime  
    #args[:startTime] = "MM-dd-yyyy HH:mm:ss"                               #This is optional  
    #args[:endtime] = "MM-dd-yyyy HH:mm:ss"                             #This is optional  
  
    #If you need the result in a paginated format use the below arguments  
    args[:pageNumber] = "1"                                     #This is optional  
    args[:pageSize] = "10"                                      #This is optional  
  
    args[:elementToken] = '00f6ea45ce42dffd5189b67800a665ac'  
  
    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/twilio/search')  
  
    uri.query = parameterize(args)  
  
    response, parsedResponse = invokeElement(uri)  
  
    puts "Response from search invocation - #{response.code} #{response.message}: #{response.body}\n\n"  
  
    if !parsedResponse[:success]  
  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
  
    end  
  
  end  
  
  # Private method for attaching parameters to uri  
  def parameterize(params)  
  
    URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))  
  
  end  
  
  # Private method for making http connection, passing request, and receiving response  
  def invokeElement(uri)  
  
    http = Net::HTTP.new(uri.host, uri.port)  
    http.use_ssl = (uri.scheme == 'https')  
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    req = Net::HTTP::Get.new(uri.request_uri)  
    response = http.start {|http| http.request(req)}  
  
    # Return unparsed response and parsed JSON from response  
    return response, JSON.parse(response.body, :symbolize_names => true)  
  
  end  
  
  private :parameterize, :invokeElement  
  
end  
  
# twilioTest = TwilioSampleCode.new  
  
# begin  
  
#   # Checking to see if the messaging is live and active  
#   twilioTest.ping  
  
#   # Sending a message  
#   messageId = twilioTest.sendMessage  
  
#   # Checking message details for the given messageId  
#   twilioTest.messageDetails(messageId) unless messageId.nil?  
  
#   # Search for all messages  
#   twilioTest.searchMessage  
  
#   # Find out element usage  
#   twilioTest.elementsUsage  
  
# rescue  
  
#   puts $!.inspect, $@  
  
# end  
