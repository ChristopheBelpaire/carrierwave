# encoding: utf-8
require 'net/ftp'


module CarrierWave
  module Storage
    class Ftp < Abstract
      
      class File
        def initialize(uploader, path)
          @uploader, @path = uploader, path
        end
        
        def url
          http_path = @uploader.store_path.sub @uploader.ftp_http_path_prefix,''
          return "#{@uploader.ftp_http_host}/#{http_path}#{::File.basename(@path)}"
        end  
      end  
      
      
      def store!(file)
        path = ::File.expand_path(uploader.store_path, uploader.root)
        mkpath("/#{::File.dirname(uploader.store_path)}")        
        
        connection.putbinaryfile(file.path, uploader.store_path)
      end

      def retrieve!(identifier)
        path = ::File.expand_path(uploader.store_path(identifier), uploader.root)
        CarrierWave::Storage::Ftp::File.new(@uploader, path)
      end
              
      def connection 
         @connection ||= Net::FTP.new(@uploader.ftp_host, @uploader.ftp_login, @uploader.ftp_password)
      end
      
      private
      
      def mkpath (dir, to_create='')
        unless dir.empty?
          to_create = to_create + (dir.slice /\/[^\/]*/)  
          connection.mkdir to_create rescue nil
          mkpath (dir.sub /\/[^\/]*/,""), to_create
        end
      end
      
    end
  end
end      