require 'openssl'
require 'base64'

class ServiceAuthentication
  def initialize(key, params, path, method, time)
    @key    = key
    @method = method
    @time   = time
    @params = params
    @path   = path
  end

  def sign
    Base64.encode64(OpenSSL::HMAC.digest(digest, @key, data)).chomp
  end

  def data
    @params["path"]= @path
    @params["method"] = @method
    @params["time"] = @time
    JSON.dump(@params)
  end

  def digest
    OpenSSL::Digest::Digest.new('sha1')
  end

end