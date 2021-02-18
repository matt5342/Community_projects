class HomeController < ApplicationController
  def welcome
    # flash[:user] = nil
    flash[:status] = nil
  end
end
