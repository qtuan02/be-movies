module Message
  MESSAGES = {
    get_all_success: "Get list successfully.",
    get_success: "Find one successfully.",
    create_success: "Created successfully.",
    upload_success: "Uploaded sucessfully.",
    create_fail: "Created failed!",
    destroy_success: "Deleted successfully.",
    update_success: "Updated sucessfully.",
    field_empty: "Required fields must not be empty!",
    error: "An error has occurred!",
    not_found: "Not found!",
  }

  def self.get(key)
    MESSAGES[key] || "Không tìm thấy thông báo!"
  end
end