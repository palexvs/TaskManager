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

  describe "login" do

    describe "with not exists user" do
      let(:user) { build(:user) }
      before do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
        click_button "Login"
      end
      it { should have_selector('#modal div.alert-error p', text: 'Wrong email or password') }
    end

    describe "with valid information" do
      let(:user) { create(:user) }
      before do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
        click_button "Login"
      end
      it { should have_selector('div.navbar li.user_email a', text: user.email) }
      it { find('div.navbar li.logout a').should be_visible }
      it { find('div.navbar li.login a').should_not be_visible }
    end  

  end

  describe "register" do
    describe "with invalid information" do
      let(:user) { build(:user_invalid_password) }
      before do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
        click_button "Register"
      end
      it { should have_selector('#modal div.alert-error p', text: 'Password is too short (minimum is 6 characters)') }
    end

    describe "with dup email" do
      let(:user) { create(:user) }
      before do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
        click_button "Register"
      end
      it { should have_selector('#modal div.alert-error p', text: 'Email has already been taken') }
    end  

    describe "with valid information" do
      let(:user) { build(:user) }
      before do
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
        click_button "Register"
      end
      it { should have_selector('div.navbar li.user_email a', text: user.email) }
    end  
  end  

end
