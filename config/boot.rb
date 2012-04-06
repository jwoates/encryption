# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)
require 'pp'
require 'crypt/gost'

#require 'newrelic_rpm'
# FB settings addet to /app/app.rb
#require './config/' + PADRINO_ENV

##
# Enable devel logging
#
# Padrino::Logger::Config[:development] = { :log_level => :devel, :stream => :stdout }
# Padrino::Logger.log_static = true
#

##
# Add your before load hooks here
#
Padrino.before_load do  def match(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end

  def base_uri
    base_uri_raw = request.env["HTTP_HOST"]+request.env["SCRIPT_NAME"]
    path = URI.parse(request.env["REQUEST_URI"]).path
    base_uri = "http://"+base_uri_raw.split(path)[0]
  end

  def curr_path
    base_uri_raw = request.env["HTTP_REFERER"]
  end

end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!
