class Admin::BadgesController < Admin::BaseController

  before_action :set_badges, only: %i[index]
  before_action :set_badge, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
    @badge = Badge.new
  end

  def edit
  end

  def create

    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badge_path(@badge.id), notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badge_path(@badge.id)
    else
      render :edit
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def set_badges
    @badges = Badge.all
  end

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    p params
    params.require(:badge).permit(:title, :file_name, :rule)
  end
end