def valid_signin()
  @user = create(:user)

  visit root_path 

  fill_in "user_email",    with: @user.email
  fill_in "user_password", with: @user.password

  click_on "Login"
end