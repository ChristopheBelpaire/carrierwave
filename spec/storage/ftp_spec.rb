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
      config.ftp_host  = 'ftp.filmswap.in'
      config.ftp_login = 'paulhenr'
      config.ftp_password = 'Mvy6TP9rAbmr'
    end
    
    @uploader = FtpSpecUploader.new
    @storage = CarrierWave::Storage::Ftp.new(@uploader)
    @file = CarrierWave::SanitizedFile.new(file_path('portrait.jpg'))
    
  end  
  
  it 'store' do
      @storage.store!(@file)
      f = @storage.retrieve!(@file.filename)
      puts f.url
  end
  
end    