##
#
# Author: Horacio Sanson (hsanson at gmail)
# Date:   2011/02/20
#
# Descr:
#    Sup mail client hook to load gmail contacts into the mail client.
#
# Installation:
#    To use this script you need ruby and rubygems 1.8 and the gdata gem. To
#    install these in Ubuntu/Kubuntu use the following commands.
#
#      sudo aptitude install ruby1.8 rubygems-1.8 libopenssl-ruby1.8
#      sudo gem1.8 install gdata
#
#    You can also use ruby 1.9.1 and rubygems 1.9.1 but you will need to modify
#    the gdata gem that is not compatible with ruby 1.9.1. Modifying the gdata
#    gem is very easy: simply delete the require jcode and $KCODE lines in the
#    gdata source. To find were these lines are simply run the script and it
#    will show you an error about jcode and a warning about KCODE so follow the
#    backtrace and remove the problem lines.
#
#    Make sure to read the comments below to learn how to configure this script
#    to work with your GMail account.
#
#    Then simply copy this script inside your ~/.sup/hooks directory
#
# Resources:
#    - http://piao-tech.blogspot.com/2010/01/google-contacts-in-mutt.html
#    - http://sup.rubyforge.org/wiki/wiki.pl?LbdbIntegration
#
# License:
#
#   Copyright (C) 2011 by Horacio Sanson
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to
#   deal in the Software without restriction, including without limitation the 
#   rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
#   sell copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
#   IN THE SOFTWARE.
#

require "rubygems"
require "gdata"
require "fileutils"

def update_cache

  ## Set up here your GMail account username and password
  username="patricktotzke"
  f = IO.popen("getpwd GMail")
  password=f.read().gsub(/\n/, "");

  # Make sure this value is larger than the total number of contacts you have.
  maxresults=999

  # How much time before the local cache expires in seconds.
  update_interval=3600

  # Where to store the local cache for faster query times.
  cachefile="~/.sup/gcontacts"

  # DO NOT MODIFY anything below this line unless you know what you are doing.
  user_hash = nil
  if ! File.exists?(File.expand_path(cachefile)) or Time.now - File.stat(File.expand_path(cachefile)).mtime > update_interval
    #STDERR << "Updating from gmail\n"
    user_hash = []
    client = GData::Client::Contacts.new

    begin
      client.clientlogin("#{username}@gmail.com", password)
    rescue GData::Client::AuthorizationError
      STDERR << "Failed to authenticate\n"
      return nil
    rescue => e
      STDERR << "Failed to log into Gmail: #{e}\n"
    end

    # Create a hash list of all users
    feeds = client.get("http://www.google.com/m8/feeds/contacts/#{username}%40gmail.com/full?max-results=#{maxresults}").to_xml
    feeds.elements.each('entry') { |entry|
      name = entry.elements['title'].text
      id = entry.elements['id'].text

      entry.elements.each('gd:email') { |email|
        if name and ! name.empty?
          user_hash.push("#{name} <#{email.attribute('address').value}>")
        end
        user_hash.push("#{email.attribute('address').value}")             # To allow completion for name and email
      }
    }

    File.open(File.expand_path(cachefile),"wb") { |fd|
      fd << Marshal.dump(user_hash)
    }

    user_hash
  else
    #STDERR << "Updating from local cache\n"
    user_hash = []
    if File.exists?(File.expand_path(cachefile))
      File.open(File.expand_path(cachefile),"rb") { |fd|
        user_hash = Marshal.load(fd.read)
      }
    end
    user_hash
  end
end

# Run the update_cache method that returns an array of gmail contacts compatible
# with sup hook.
update_cache
