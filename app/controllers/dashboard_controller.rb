class DashboardController < BaseController

  def index
    begin
      @permission = Permission.find_by_user_id(current_user) || Permission.new
      Drive::Folder.new(current_user) unless  @permission.accept
      @documents = build_drive.list
    rescue
      sign_out current_user
      redirect_to root_path
    end
  end

  private

  def build_drive
    @drive = Drive::DocumentFile.new(current_user)
  end

end
