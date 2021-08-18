class HomeController < ApplicationController
  def index
    if(user_signed_in?)
      @balance = '%.2f' % User.find(current_user.id).balance
    else
      @balance = nil
    end
  end

  def about
  end

  def contact
  end
end
