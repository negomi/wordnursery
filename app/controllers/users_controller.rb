class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "You're signed up!"
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def delete
  end
end
