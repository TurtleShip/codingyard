def login_with(username, password)
  visit login_path
  fill_in 'Username', with: username
  fill_in 'Password', with: password
  click_button 'Log in'
end

def login(user)
  login_with(user.username, 'password')
end
