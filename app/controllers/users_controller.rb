class UsersController < ApplicationController
 
  layout 'application'
   
  def new  
    @user = User.new  
  end  

  def create  
    @user = User.new(params[:user])  
    if @user.save  
      flash[:notice] = "Registration successful."  
      redirect_to root_url  
    else  
      flash[:notice] = "Try again..."
      render :new  
    end  
  end

end
