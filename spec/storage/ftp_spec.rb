require 'spec_helper'

class FtpSpecUploader < CarrierWave::Uploader::Base
  storage CarrierWave::Storage::Ftp
  
  def store_dir
    ""
  end
  
end

describe CarrierWave::Storage::Ftp do
  before do
    CarrierWave.configure do |config|
      config.reset_config
      config.ftp_host  = FTP_HOST
      config.ftp_login = FTP_LOGIN
      config.ftp_password = FTP_PASSWORD
      config.ftp_http_host  = FTP_HTTP_HOST
      
    end
    
    @uploader = FtpSpecUploader.new
    @storage = CarrierWave::Storage::Ftp.new(@uploader)
    @file = CarrierWave::SanitizedFile.new(file_path('portrait.jpg'))
    
  end  
  
  it 'store' do
      @storage.store!(@file)
      puts f.url
  end
  
end    