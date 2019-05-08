require 'google/apis/drive_v2'

module Drive
  class Folder

    def initialize(current_user)
      secrets = Drive::Authentication.call(current_user)
      @drive = Google::Apis::DriveV2::DriveService.new
      @drive.authorization = secrets.to_authorization
      @current_user = current_user
      create(ENV['APP_FOLDER'])
    end

    def create(title)
      folder = @drive.list_files(q: "title contains '#{title}'")
      unless folder.items.size > 0
        metadata = Google::Apis::DriveV2::File.new(title: title, mime_type: 'application/vnd.google-apps.folder')
        result = @drive.insert_file(metadata)
        Permission.create(:user => @current_user, :accept => true, :uuid => result.id)
      else
        Permission.where(user_id: @current_user).first_or_create do |permission|
          permission.user = @current_user
          permission.accept = true
          permission.uuid = folder.items[0].id
        end
      end
    end
  end
end
