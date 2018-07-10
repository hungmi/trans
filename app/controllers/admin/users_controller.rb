class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  # GET /users
  def index
    authorize [:admin, :user], :index?
    @users = @q.result(distinct: true).order(updated_at: :desc)
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    authorize [:admin, @user]
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize [:admin, @user]

    if @user.save
      flash[:success] = I18n.t('flash.create_success')
      redirect_to [:admin, @user]
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = I18n.t('flash.update_success')
      redirect_to [:admin, @user]
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    if User.admin.size > 1
      @user.destroy
      flash[:success] = I18n.t('flash.destroy_success')
    end
    redirect_to admin_users_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    	authorize [:admin, @user]
    end

    def set_search
      @q = User.ransack(params[:q])
      @nav_search_symbol = :name_cont
      @nav_search_placeholder = nil
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :role, :password, :password_confirmation)
    end
end