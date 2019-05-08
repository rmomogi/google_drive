require 'google/apis/drive_v2'

module Drive
  class DocumentFile

    def initialize(current_user)
      secrets = Drive::Authentication.call(current_user)
      @drive = Google::Apis::DriveV2::DriveService.new
      @drive.authorization = secrets.to_authorization
      @current_user = current_user
    end

    def create(document)
      file = generate_file(document)
      metadata = Google::Apis::DriveV2::File.new(title: document.title)
      parent = Google::Apis::DriveV2::ParentReference.new(id: current_folder.uuid, is_root: true)
      metadata.parents = [parent]

      result = @drive.insert_file(metadata, upload_source: file.path, content_type: 'text/plain')
      document.uuid = result.id
      document.save
    end

    def update(document)
      file = generate_file(document)
      @drive.update_file(document.uuid, file)
    end

    def destroy(document)
      result = @drive.delete_file(document.uuid)
      document.destroy
    end

    def list
      begin
        result = @drive.list_files(q: "'#{current_folder.uuid}' in parents")
        documents = []
        result.items.each do |document|
          doc = Document.find_by_uuid(document.id) || Document.new
          if doc.valid?
            documents.push Document.find_by_uuid(document.id)
          else
            create_document(document)
          end
        end
        return documents
      rescue
        raise 'Unauthorized'
      end
    end

    private

    def generate_file(document)
      file = Tempfile.new ""
      file << document.content
      file.close
      return file
    end

    def current_folder
      Permission.find_by_user_id @current_user.id
    end

    def create_document(doc)
      @drive.get_file(doc.id, download_dest: "/tmp/#{doc.id}")
      file = File.open("/tmp/#{doc.id}")
      document = Document.create(user: @current_user, title: doc.original_filename, content: file.read, uuid: doc.id)
    end
  end
end
