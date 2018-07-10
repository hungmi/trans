class Admin::PeopleController < AdminController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /people
  def index
    authorize [:admin, :person], :index?
    @people = @q.result(distinct: true).order(updated_at: :desc)
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    authorize [:admin, @person]
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    authorize [:admin, @person]

    if @person.save
      flash[:success] = I18n.t('flash.create_success')
      redirect_to [:admin, @person]
    else
      render :new
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      @person.cover.purge_later if params[:person][:remove_cover].present?
      flash[:success] = I18n.t('flash.update_success')
      redirect_to [:admin, @person]
    else
      render :edit
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
    flash[:success] = I18n.t('flash.destroy_success')
    redirect_to admin_people_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    	authorize [:admin, @person]
    end

    def set_search
      @q = Person.ransack(params[:q])
      @nav_search_symbol = :en_name_or_zh_name_or_en_title_or_zh_title_or_en_description_or_zh_description_cont
      @nav_search_placeholder = nil
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(:en_name, :zh_name, :en_title, :zh_title, :en_description, :zh_description, :cover)
    end
end