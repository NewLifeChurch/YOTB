module Features
  module BloggingHelpers
    def create_post(devo)
      find("#listActionsOutput .add a").click
      fill_in_form(:new, devo)

      expect(page).to have_content "YOU'RE ABOUT TO PUBLISH THIS BLOG POST"
      click_on "Keep as Draft"
      expect(page).to have_content "BLOG POST SET TO"
    end

    def edit_post(devo)
      within "#listOutput" do
        click_on devo.day
      end

      expect(page).to have_content "BLOG POSTS"
      fill_in_form(:edit, devo)
      expect(page).to have_content "BLOG POST SAVED"
    end

    def fill_in_form(type, devo)
      Capybara.default_max_wait_time = 1
      ## Fill in Form
      # Add Title
      find("#title").set(devo.day)

      # Select Blog Type
      find("#selectBlog").select("Bible")

      # Category Selection
      category_link_reference = "#selectedRecordsContainerCategory1 .item a"
      if type == :edit && has_css?(category_link_reference)
        find(category_link_reference).click
        click_on "Add another category"
      end
      find("#recordListCategory1").select("Daily")

      # Author Selection
      author_link_reference = "#authorRoleIds218698 a"

      if type == :edit && has_css?(author_link_reference)
        find(author_link_reference).click
      end

      find("#existingauthorRoleIds").select("Larry Stockstill")

      # Post Date
      find("#postdate").set(devo.new_date)

      # Post Text
      execute_script("$('#mceu_23').remove()")
      execute_script("$('#text').show()")
      find("#text").set(devo.text)

      # Post Tags (Scriptures)
      # for some reason, they made the keywords box 'audio' in the CMS (?)
      verses = devo.verses.map(&:reference).join(',')
      find("#audio").set(verses)

      # Main Verse Text
      main_verse_id = page.html.scan(/custom_mainscripture\w*/).first
      find("##{main_verse_id}")
        .set(devo.main_verse_text)

      # Main Verse Reference
      main_reference_id = page.html.scan(/custom_mainscripturereference\w*/).first
      find("##{main_reference_id}")
        .set(devo.main_verse_reference)

      # Submit Form
      Capybara.default_max_wait_time = 15
      find("#saveButton").click
    end

    def log_into_ekklesia
      visit "http://monkid.com"
      fill_in "Email",    with: ENV["MONK_ID"]
      fill_in "Password", with: ENV["MONK_PASSWORD"]
      click_on "Sign in"

      # Dashboard
      visit "https://my.ekklesia360.com"
      expect(page).to have_content "WELCOME TO YOUR DASHBOARD"
    end

    def post_exists?(devo)
      day = devo.day

      fill_in "Search this list", with: day
      sleep 2

      Capybara.default_max_wait_time = 1

      result = false

      within "#listOutput" do
        result = has_content?(/\b#{day}\b/) && !has_content?("No blog posts")
      end

      Capybara.default_max_wait_time = 15

      result
    end

    def visit_blog_dashboard
      visit "https://my.ekklesia360.com/BlogPost/list"
      expect(page).to have_content "MANAGE BLOG POSTS"
    end
  end
end

RSpec.configure do |config|
  config.include Features::BloggingHelpers, type: :feature
end
