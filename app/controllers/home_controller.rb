class HomeController < ApplicationController
  def index
    return render '/welcome' unless user_signed_in?

    @source = []

    render
  end
end
