module Netdocuments

  def self.logger
    Logger.new(STDOUT) #Rails.logger#Logger.new(STDOUT)
  end
end
