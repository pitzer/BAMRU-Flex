class ApplicationController < ActionController::Base
  protect_from_forgery

  def device
    agent = env["HTTP_USER_AGENT"]
    case agent
      when /Kindle/      then "Kindle"
      when /Android/     then "Android"
      when /iPod/        then "iPod"
      when /iPhone/      then "iPhone"
      when /iPad/        then "iPad"
      when /BlackBerry/  then "BlackBerry"
      when /MSIE/        then "IE"
      when /Silk/        then "Silk"
      when /Firefox/     then "Firefox"
      when /Konqueror/   then "Konqueror"
      when /Netscape/    then "Netscape"
      when /Opera/       then "Opera"
      when /Chrome/      then "Chrome"
      when /Safari/      then "Safari"
      else  "Unknown"
    end
  end

  def tablet_device?
    %w(iPad iPod Kindle).include? device
  end

  def phone_device?
    return true if device == "Chrome" && ENV['RAILS_ENV'] == "development"
    %w(Android iPhone BlackBerry).include? device
  end

end
