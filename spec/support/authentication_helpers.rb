# spec/support/authentication_helpers.rb
RSpec.shared_context "authentication helpers" do
  def sign_in_as(user)
    # controller spec の場合
    if defined?(@request) && @request
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, user
    else
      # request spec の場合（Devise::Test::IntegrationHelpers が効く）
      sign_in user, scope: :user
    end
  end

  def sign_out_as
    if defined?(@request) && @request
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out :user
    else
      sign_out :user
    end
  end
end
