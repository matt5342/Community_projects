class HomeController < ApplicationController
  def welcome
    flash[:status] = nil
  end
end
