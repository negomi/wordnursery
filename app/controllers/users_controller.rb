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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
