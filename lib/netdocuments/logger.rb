module Netdocuments

  def self.logger
    Netdocuments.configuration.logger #Logger.new(STDOUT) #Rails.logger#Logger.new(STDOUT)
  end
end
