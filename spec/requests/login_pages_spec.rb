require 'spec_helper'

describe "Authentication", :js => true do
  before { visit root_path }
  subject { page }

  describe "Check login_page content" do
    it { should have_selector('h3', text: 'Login/Register') }
    it { should have_field('user_email', :type => 'email') }
    it { should have_field('user_password', :type => 'password') }
    it { should have_button('Login') }
    it { should have_button('Register') }
  end

  describe "with invalid information" do
    let(:user) { build(:user_invalid_password) }
    before do
      fill_in "user_email",    with: user.email
      fill_in "user_password", with: user.password
      click_button "Login"
    end
    it { should have_selector('div#alert-area-modal div.alert-error p', text: 'Wrong email or password') }
  end

  describe "with valid information" do
    let(:user) { build(:user) }
    before do
      fill_in "user_email",    with: user.email
      fill_in "user_password", with: user.password
      click_button "Login"
    end
    it { should have_selector('div.navbar li.user_email a', text: user.email) }
  end  

end
