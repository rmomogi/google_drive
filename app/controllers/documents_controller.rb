class DocumentsController < BaseController
  respond_to :html, :json
  before_action :build_drive, only: [:create, :update, :destroy]
  before_action :find_document, only: [:edit,  :update, :destroy]
  
  def new
    @document = Document.new
    @document.content = Faker::Lorem.paragraph
    respond_with(@document)
  end

  def create
    begin
      @document = Document.new(document_params)
      @document.user = current_user
      if @document.valid?
        @drive.create(@document)
      else
        render
      end
    rescue Exception => e
      
    end
  end

  def edit
    
  end

  def update
    @document.update_attributes(document_params)
    if @document.valid?
      @drive.update(@document)
    else
      render
    end
  end

  def destroy
    @drive.destroy(@document)
  end

  private

  def document_params
    params.require(:document).permit(:title, :content)
  end

  def build_drive
    @drive = Drive::DocumentFile.new(current_user)
  end

  def find_document
    @document = Document.find params[:id]
  end

end
