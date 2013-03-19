module FeaturesHelpers
  def signin
    @user = FactoryGirl.create(:user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = {
        'uid' => @user.id,
        'provider' => 'twitter',
        'info' => {
          'name' => @user.name
        }
      }
    visit '/signin'
  end

  def signout
    visit '/signout'
  end

  def current_user
    @user
  end
end
