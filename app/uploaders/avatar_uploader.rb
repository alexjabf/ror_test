# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :scale => [400, 400]
  #
   def scale(width, height)
     # do something
   end

  # Create different versions of your uploaded files:
  version :home_index do
    process :resize_to_fit => [700, 400]
  end
   
  version :event_index do
    process :resize_to_fit => [700, 300]
  end
   
  version :event_show do
    process :resize_to_fit => [750, 500]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(gif png jpeg jpg)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  def default_url 
    "https://lh3.googleusercontent.com/WMQUaCArVm8cf3wUeBFJjjjSkDFF24GYw97-gyajwaZVDsLLBNe2EkGuOl0IFtmWHrFpqNW_cw=w340-rw"
  end

end
