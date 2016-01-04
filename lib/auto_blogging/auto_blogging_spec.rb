require "rails_helper"

feature "Auto Generating Blog Posts" do
  background do
    WebMock.allow_net_connect!
    ActiveRecord::Base.establish_connection "development"
  end

  background do
    log_into_ekklesia
    visit_blog_dashboard
  end

  scenario "Blog Posts for 2016 YOTB get created/edited" do
    (360..360).each do |day|
      devo = Devo.find_by(day: day)

      if post_exists?(devo)
        edit_post(devo)
      else
        create_post(devo)
      end

      visit_blog_dashboard
    end
  end
end
