class ListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    # Check if user has a word stored in session (i.e. been prompted to log in)
    if session[:word]
      add_to_nursery(session[:word])
      session[:word] = nil
    else
      @lists = current_user.lists.all
    end
  end

  def show
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
