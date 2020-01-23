class AccountActivationsController < ApplicationController
     def edit
          user = User.find_by(email: params[:email])
          if user && user.authenticated(:activated, params[:id]) && !user.activated?
               user.activate
               flash[:success] = "Account activated!"
               redirect_to user
          else
               flash[:danger] = "Invalid activation link"
               redirect_to root_url
          end
     end

end
