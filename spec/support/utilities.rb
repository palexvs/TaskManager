def valid_signin()
  visit root_path 
  user = build(:user)
  fill_in "user_email",    with: user.email
  fill_in "user_password", with: user.password
  click_button "Login"
end