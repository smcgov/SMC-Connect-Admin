require "spec_helper"

describe "ability to add an admin to a location" do
  context "when neither master admin nor location admin" do
    it "doesn't allow adding an admin" do
      user = create(:user)
      login_user(user)
      visit_locations
      click_link "San Mateo Free Medical Clinic"
      expect(page).to_not have_content ("Add an admin")
    end
  end

  context "when master admin" do
    it "allows adding an admin" do
      login_admin
      visit_locations
      click_link "San Mateo Free Medical Clinic"
      expect(page).to have_content ("Add an admin")
    end
  end

  context "when location admin", js: true do
    it "allows adding an admin" do
      new_admin = create(:second_user)
      set_user_as_admin(new_admin.email, "San Mateo Free Medical Clinic")
      login_user(new_admin)
      visit_locations
      click_link "San Mateo Free Medical Clinic"
      expect(page).to have_content ("Add an admin")
      delete_all_admins
    end
  end
end