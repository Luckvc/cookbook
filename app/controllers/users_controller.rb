class UsersController < ApplicationController
  
  def my_lists
    @lists = current_user.lists
  end
end