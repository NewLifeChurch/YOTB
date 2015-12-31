module Api
  class DevosController < ApplicationController
    def index
      devos = Devo.order(:day)
      render json: format_devos(devos)
    end

    def show
      devo = fetch_devo
      render json: format_devo(devo)
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

    def format_devo(devo)
      return {} unless devo

      {
        day: devo.day,
        date: devo.date,
        devotional: devo.text,
        verses: devo.verses.map(&:reference)
      }
    end

    def format_devos(devos = [])
      devos.map do |devo|
        format_devo(devo)
      end
    end
  end
end
