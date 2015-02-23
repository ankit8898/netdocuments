require 'json'
require 'httparty'
require 'awesome_print'
require 'time_difference'
require 'parallel'
require 'logger'
require_relative 'netdocuments/base'
require_relative 'netdocuments/cabinet'
require_relative 'netdocuments/folder'
require_relative 'netdocuments/node'
require_relative 'netdocuments/document'
require_relative 'netdocuments/path_formatter'
require_relative 'netdocuments/configuration'
require_relative 'netdocuments/client'
require_relative 'netdocuments/access_token_master'

$logger = Logger.new("log/netdocuments.log")



module Netdocuments

  class << self
    attr_writer :configuration
  end

  def self.configuration
    Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
