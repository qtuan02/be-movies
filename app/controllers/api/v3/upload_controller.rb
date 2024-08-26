class Api::V3::UploadController < ApplicationController
  before_action :upload_service

  def upload_poster
    result = @upload_service.upload_poster(params[:poster])
    json_response Message.get(:upload_success), true, result['secure_url'], :ok
  end

  private
    def upload_service
      @upload_service = UploadService.new
    end

end