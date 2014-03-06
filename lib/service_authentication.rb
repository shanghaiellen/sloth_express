require 'openssl'
require 'base64'


class ServiceAuthentication
  def initialize(key, params, path, method, time, sig=nil)
    @key    = key
    @params = params
    @path   = path
    @method = method
    @sig    = sig
    @time   = time
  end

  def sign
    Base64.encode64(OpenSSL::HMAC.digest(digest, @key, data)).chomp
  end

  def data
    @params.to_query+"&path=#{@path}&method=#{@method}&time=#{@time}"
  end

  def digest
    OpenSSL::Digest::Digest.new('sha1')
  end

  def authenticated?
  end

end