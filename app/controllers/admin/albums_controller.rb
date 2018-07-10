class Admin::AlbumsController < AdminController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /albums
  def index
    authorize [:admin, :album], :index?
    @albums = @q.result(distinct: true).order(updated_at: :desc)
  end

  # GET /albums/1
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
    authorize [:admin, @album]
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  def create
    @album = Album.new(album_params)
    authorize [:admin, @album]

    if @album.save
      flash[:success] = I18n.t('flash.create_success')
      redirect_to [:admin, @album]
    else
      render :new
    end
  end

  # PATCH/PUT /albums/1
  def update
    if @album.update(album_params)
      @album.images.where(id: params[:album][:remove_images].keys).map(&:purge_later) if params[:album][:remove_images].present?
      flash[:success] = I18n.t('flash.update_success')
      redirect_to [:admin, @album]
    else
      render :edit
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
    flash[:success] = I18n.t('flash.destroy_success')
    redirect_to admin_albums_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    	authorize [:admin, @album]
    end

    def set_search
      @q = Album.ransack(params[:q])
      @nav_search_symbol = :title_or_description_cont
      @nav_search_placeholder = nil
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.require(:album).permit(:title, :description, images: [])
    end
end