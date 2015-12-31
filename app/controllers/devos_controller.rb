class DevosController < ApplicationController
  layout false, only: :show

  def index
    @devos = Devo.order(:day)
  end

  def show
    @devo = fetch_devo
  end

  private

  def fetch_devo
    day_or_date = params[:id]

    if day_or_date.length > 3
      Devo.find_by(date: day_or_date)
    else
      Devo.find_by(day: day_or_date)
    end
  end
end
