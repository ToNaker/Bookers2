# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  def destroy
    # Devise の destroy が redirect を返すので邪魔しない
    super do
      flash[:notice] = "successfully"
    end
  end
end
