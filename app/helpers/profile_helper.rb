require 'digest/md5'

module ProfileHelper
  def gravatar_url email
    hash = Digest::MD5.hexdigest email.downcase
    "http://www.gravatar.com/avatar/#{hash}"
  end
end