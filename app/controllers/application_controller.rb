class ApplicationController < ActionController::API
  include Helper
  include Message
  include Response

  rescue_from StandardError, with: :handle_internal_server
  rescue_from NotImplementedError, with: :handle_internal_server
  
  rescue_from CustomError, with: :handle_custom_error

  def index
    render html: "<div style='display: flex; justify-content: center; align-items: center; height: 100%'><h1>API MOVIES!</h1></div>".html_safe
  end

  private
    def handle_internal_server(exception)
      json_response Message.get(:error), false, nil, :internal_server_error
    end
    
    def handle_custom_error(exception)
      json_response exception.message, false, nil, exception.status
    end

end
