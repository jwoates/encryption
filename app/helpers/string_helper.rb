# Add string encryption/decryption methods 
# add to gemfile:
# gem 'crypt'
# $ bundle install

# how to use, create a random string and generate apublic and private key

#create random string
# $ openssl rand -base64 48
# copy the output to /config/passphrase.txt

# use random string when prompted while creating keys
# generate private key
# $ openssl genrsa -aes256 -out private.pem 2048
# copy to /config/private.pem

# generate public key
# $ openssl rsa -in private.pem -out public.pem -outform PEM -pubout
# copy to /config/public.pem

# more at: http://trevmex.com/post/1092972042/extending-the-ruby-string-class-to-add-openssl


class String
  require 'openssl'
  require 'base64'

  def encrypt
    public_key_file = File.join(PADRINO_ROOT, 'config', 'public.pem')
    public_key = OpenSSL::PKey::RSA.new(File.read(public_key_file))
    Base64.encode64(public_key.public_encrypt(self))
  end
  def decrypt
    private_key_file = File.join(PADRINO_ROOT, 'config', 'private.pem')
    passphrase_file = File.join(PADRINO_ROOT, 'config', 'passphrase.txt')
    private_key = OpenSSL::PKey::RSA.new(File.read(private_key_file), File.read(passphrase_file).rstrip)
    private_key.private_decrypt(Base64.decode64(self))
  end
end