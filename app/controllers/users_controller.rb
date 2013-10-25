class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
  end

  def new
  end

  def create
    User.create(params[:user])
    User.list.create(name: "kindergarten")
    User.list.create(name: "school")
    User.list.create(name: "graduated")
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
