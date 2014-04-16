def create_user_and_sign_in
  user = FactoryGirl.create :user
  visit new_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end
