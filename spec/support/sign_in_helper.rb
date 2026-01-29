# spec/support/sign_in_helper.rb
module SignInHelper
  def sign_in_as(user)
    login_as(user, scope: :user)
  end
end
