module AuthenticationHelper
  def login
    user = FactoryGirl.create(:user)
    visit root_path
    within("#login") do
      fill_in 'user_username', with: user.username
      fill_in 'user_password', with: user.password
    end
    click_button "Login"

    return user
  end
end
