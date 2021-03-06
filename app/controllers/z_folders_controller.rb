class ZFoldersController < ApplicationItemsBaseController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @z_folders = @folder.folders
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @z_folder = ZFolder.new(folder: @folder)
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @z_folder = ZFolder.new(folder_params)

    respond_to do |format|
      if @z_folder.save
        format.html { redirect_to @z_folder, notice: 'folder was successfully created.' }
        format.json { render :show, status: :created, location: @z_folder }
      else
        format.html { render :new }
        format.json { render json: @z_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @z_folder.update(folder_params)
        format.html { redirect_to @z_folder, notice: 'folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @z_folder }
      else
        format.html { render :edit }
        format.json { render json: @z_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @z_folder.destroy
    respond_to do |format|
      format.html { redirect_to z_folders_url, notice: 'folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @z_folder = ZFolder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:z_folder).permit(:label, :folder_id)
    end
end
