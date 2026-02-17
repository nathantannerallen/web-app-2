class TacosController < ApplicationController

  def index
    @fillings = ["Carnitas", "Al Pastor", "Steak", "Fish", "Veggie", "Mushrooms"]
    # render :template => "tacos/index"
  end

end