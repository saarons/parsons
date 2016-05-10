require 'java'
require 'drb/drb'
require 'bundler/setup'

# The URI for the server to connect to
SERVER_URI = 'druby://0.0.0.0:8787'.freeze
UTILITY = com.google.i18n.phonenumbers.PhoneNumberUtil.getInstance
E164 = com.google.i18n.phonenumbers.PhoneNumberUtil::PhoneNumberFormat::E164

class PhoneServer
  def e164?(string)
    number = UTILITY.parse(string, nil)
    UTILITY.isValidNumber(number) && string == UTILITY.format(number, E164)
  rescue
    false
  end
end

# The object that handles requests on the server
FRONT_OBJECT = PhoneServer.new
DRb.start_service(SERVER_URI, FRONT_OBJECT)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join
