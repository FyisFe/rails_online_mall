class SessionsController < ApplicationController

    def new
      
    end
  
    def create
      if user = login(params[:email], params[:password])
        flash[:notice] = "Sign in successfully"
        redirect_to root_path
      else
        flash[:notice] = "Your email address or password is incorrect."
        redirect_to new_session_path
      end
    end
  
    def destroy
      logout
      flash[:notice] = "Log out"
      redirect_to root_path
    end
  
  end