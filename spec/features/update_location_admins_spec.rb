require "spec_helper"

feature "Update a location's admins" do
  background do
    login_admin
  end

  scenario "when location doesn't have any admins" do
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='admins[]']")
  end

  scenario "by adding 2 new admins", :js => true do
    visit_location_with_no_phone
    add_two_admins
    visit_location_with_no_phone
    total_admins = page.
      all(:xpath, "//input[@type='text' and @name='admins[]']")
    total_admins.length.should eq 2
    delete_all_admins
    visit_location_with_no_phone
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='admins[]']")
  end

  scenario "with empty admin", :js => true do
    visit_test_location
    click_link "Add an admin"
    page.should have_selector(
      :xpath, "//input[@type='text' and @name='admins[]']")
    click_button "Save changes"
    visit_test_location
    page.should have_no_selector(
      :xpath, "//input[@type='text' and @name='admins[]']")
  end

  scenario "with 2 admins but one is empty", :js => true do
    visit_test_location
    click_link "Add an admin"
    fill_in "admins[]", with: "moncef@samaritanhouse.com"
    click_link "Add an admin"
    click_button "Save changes"
    visit_test_location
    total_admins = page.
      all(:xpath, "//input[@type='text' and @name='admins[]']")
    total_admins.length.should eq 1
    delete_all_admins
  end

  scenario "with valid admin", :js => true do
    visit_test_location
    click_link "Add an admin"
    fill_in "admins[]", with: "moncef@samaritanhouse.com"
    click_button "Save changes"
    visit_test_location
    find_field('admins[]').value.should eq "moncef@samaritanhouse.com"
    delete_all_admins
  end

  scenario "with invalid admin", :js => true do
    visit_test_location
    click_link "Add an admin"
    fill_in "admins[]", with: "moncefsamaritanhouse.com"
    click_button "Save changes"
    expect(page).to have_content "Please enter a valid admin email address"
  end
end