class BadgesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_badges, only: %i[index]

  def index
  end

  private

  def set_badges
    @badges = Badge.all
  end
end