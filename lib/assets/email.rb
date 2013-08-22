
require_relative 'cloud_elements_helper'
require "net/https"  
require "json"  

class Email

  extend CloudElementsHelper
  # This method is used for finding out if the element instance is live  
  def ping  
    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/sendgrid/ping')  

    uri.query = parameterize(:elementToken => '0967313f714ec4c12971a5adfbf51d1e')  

    response, parsedResponse = invokeElement(uri)  

    puts "Response from ping invocation - #{response.code} #{response.message}: #{response.body}\n\n"  

    if parsedResponse[:success]  
      puts parsedResponse[:value]  
    else  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg] 
    end  
  end  
  
  # This method is used for finding our the usage of the element  
  def elementUsage  

    args = Hash.new  

    args[:elementToken] = '0967313f714ec4c12971a5adfbf51d1e'  
    #args[:days] = "10"                                 # This is optional  
    #args[:startDate] = "MM-dd-yyyy HH:mm:ss"           # This is optional  
    #args[:endDate] = "MM-dd-yyyy HH:mm:ss"             # This is optional  
    #args[:aggregate] = "10"                            # This is optional  
    #args[:searchText] = "text"                         # This is optional  

    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/sendgrid/elementUsage')  

    uri.query = parameterize(args)  

    response, parsedResponse = invokeElement(uri)  

    puts "Response from elementUsage invocation - #{response.code} #{response.message}: #{response.body}\n\n"  

    if parsedResponse[:success]  

      puts "Number of calls to sendgrid messaging #{parsedResponse[:recordCount]}"  

      parsedResponse[:records].each do |record|  
        puts "Count: #{record[:count]}, Status: #{record[:status]}, Sent Date: #{record[:sent_date]}"  
      end  
    else  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
    end 
  end  
  
  
  # This method is used for sending messages  
  def self.sendEmail(hash)  

    json = Hash.new  
    message = Hash.new  

    #Email.sendEmail({from: 'eric.justin.allen@gmail.com', to: 'eric.allen.cr@gmail.com', subject: 'This is SWOTBOT', message: "This is a test... Of the SWOT BOT Broadcasting system"})
    #   Substitute the following  
    message[:from] = hash[:from]
    message[:to] = hash[:to]                          #This is required  

    message[:subject] = hash[:subject]                #This is required  
    message[:message] = hash[:message]                #This is required  

    #   mimeType can be text/html or text/plain.  
    #   can be omitted. Default is text/plain.  

    message[:mimeType] = 'text/html'                  #This is optional  

    #   refId can be any tracking information that you want  
    #   generally its your reference id for this request.  
    #   Can be omitted.  
    #   Uncomment the Line below to send a reference ID.  

    #message[:refId] = 'Change This'                   #This is optional  

    #   Callback is the url that you wish to be notified at for events  
    #   associated with your message.  
    #   Uncomment the Lines below to specify a Callback URL  

    #message[:callback] = 'Your Call Back URL if you wish to be notified.'          #This is optional  

    json[:message] = message                            #This is required  
    json[:elementToken] = '0967313f714ec4c12971a5adfbf51d1e'  

    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/sendgrid/send')  

    uri.query = parameterize(:elementToken => '0967313f714ec4c12971a5adfbf51d1e')  

    http = Net::HTTP.new(uri.host, uri.port)  
    http.use_ssl = (uri.scheme == 'https')  
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    req = Net::HTTP::Post.new(uri.request_uri)  
    req.content_type = 'application/json'  
    req.body = json.to_json  
    response = http.start {|http| http.request(req)}  
    parsedResponse = JSON.parse(response.body, :symbolize_names => true)  

    puts "Response from send invocation - #{response.code} #{response.message}: #{response.body}\n\n"  

    # Checking for success in the response  
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
    args[:elementToken] = '0967313f714ec4c12971a5adfbf51d1e'  
    args[:messageId] = messageId                            # This is required  

    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/sendgrid/details')  

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
    args[:text] = "Add Sample Subjects"                      #This is optional  

    #Search based on refId passed while sending the messages  
    args[:refId] = ""                                        #This is optional  

    #Search based on startTime and endTime  
    #args[:startTime] = "MM-dd-yyyy HH:mm:ss"                #This is optional  
    #args[:endtime] = "MM-dd-yyyy HH:mm:ss"                  #This is optional  

    #If you need the result in a paginated format use the below arguments  
    args[:pageNumber] = "1"                                  #This is optional  
    args[:pageSize] = "10"                                   #This is optional  

    args[:elementToken] = '0967313f714ec4c12971a5adfbf51d1e'  

    uri = URI.parse('https://console.cloud-elements.com/elements/api-v1/sendgrid/search')  

    uri.query = parameterize(args)  

    response, parsedResponse = invokeElement(uri)  

    puts "Response from search invocation - #{response.code} #{response.message}: #{response.body}\n\n"  

    if !parsedResponse[:success]  
      # In case of failure check the errorMsg in response  
      puts parsedResponse[:errorMsg]  
    end  
  end  
  
  
  private
  
  # Private method for making http connection, passing request, and receiving the response  
  def invokeElement(uri)  

    http = Net::HTTP.new(uri.host, uri.port)  
    http.use_ssl = (uri.scheme == 'https')  
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    req = Net::HTTP::Get.new(uri.request_uri)  
    response = http.start {|http| http.request(req)}  

    # Return unparsed response and parsed JSON from response  
    return response, JSON.parse(response.body, :symbolize_names => true)  
  end  
end  
