class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!

  def create
    user = User.create(params[:user])
    user.lists.create(name: "kindergarten")
    user.lists.create(name: "school")
    user.lists.create(name: "graduated")
  end
end
