class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  storage :file
end
