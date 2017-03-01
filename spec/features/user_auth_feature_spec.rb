require "rails_helper"

RSpec.describe "User login/logout", type: :feature do
  let!(:user) { FactoryGirl.create(:user) }

  it "allows user to login via homepage" do
    visit "/"
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully")
  end

  it "allows the user to logout via menu link" do
    visit "/"
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "Logout"
    expect(page).to have_content("Signed out successfully")
  end

  it "does not allow an invalid user to login" do
    visit "/"
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrong password"
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password")
  end
end
