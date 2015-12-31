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
        main_verse: {
          text: devo.main_verse_text,
          reference: devo.main_verse_reference,
        },
        devotional: devo.text,
        verses: devo.verses.map(&:reference),
        author: devo.author,
      }
    end

    def format_devos(devos = [])
      devos.map do |devo|
        format_devo(devo)
      end
    end
  end
end
