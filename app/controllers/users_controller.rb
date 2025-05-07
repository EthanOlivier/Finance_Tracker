class UsersController < ApplicationController
  def portfolio
    @user = current_user
  end
end
