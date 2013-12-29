module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create topics" => "Create Topics",
      "edit topics" => "Edit Topics",
      "delete topics" => "Delete Topics"
    } 
  end
end