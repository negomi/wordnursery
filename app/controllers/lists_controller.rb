class ListsController < ApplicationController
  def index
    @lists = current_user.lists.all
  end

  def show
    @lists = current_user.lists.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
