class Admin::PartnersController < AdminController
  before_action :set_partner, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /partners
  def index
    authorize [:admin, :partner], :index?
    @partners = @q.result(distinct: true).order(updated_at: :desc)
  end

  # GET /partners/1
  def show
  end

  # GET /partners/new
  def new
    @partner = Partner.new
    authorize [:admin, @partner]
  end

  # GET /partners/1/edit
  def edit
  end

  # POST /partners
  def create
    @partner = Partner.new(partner_params)
    authorize [:admin, @partner]

    if @partner.save
      flash[:success] = I18n.t('flash.create_success')
      redirect_to [:admin, @partner]
    else
      render :new
    end
  end

  # PATCH/PUT /partners/1
  def update
    if @partner.update(partner_params)
      flash[:success] = I18n.t('flash.update_success')
      redirect_to [:admin, @partner]
    else
      render :edit
    end
  end

  # DELETE /partners/1
  def destroy
    @partner.destroy
    flash[:success] = I18n.t('flash.destroy_success')
    redirect_to admin_partners_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_partner
      @partner = Partner.find(params[:id])
    	authorize [:admin, @partner]
    end

    def set_search
      @q = Partner.ransack(params[:q])
      @nav_search_symbol = :link_cont
      @nav_search_placeholder = nil
    end

    # Only allow a trusted parameter "white list" through.
    def partner_params
      params.require(:partner).permit(:link, :cover, :category, :order)
    end
end