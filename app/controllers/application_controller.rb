class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :add_to_nursery

  def add_to_nursery(word)
    # Check if user already has the word saved
    current_words = current_user.lists.map { |list| list.words }
    if current_words.flatten.include?(word)
      redirect_to :back, flash: { error: "You've already saved '#{word.name}'" }
    else
      current_user.lists[0].words << word
      redirect_to user_lists_path(current_user.id)
    end
  end

  def after_sign_in_path_for(resource)
    user_lists_path(current_user.id)
  end
end
