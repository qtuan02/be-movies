class UploadService < ApplicationService
  def upload_poster(file)
    begin
      Cloudinary::Uploader.upload(file, folder: 'movies')
    rescue
      raise StandardError
    end
  end
end