class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :ui_kit ]

  def home
  end

  def about_us
  end

  def ui_kit
  end
end
