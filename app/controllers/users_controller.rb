class UsersController < ApplicationController
  before_action :set_user

  def edit
    authorize! :update, @user
  end


  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_path, notice: 'User was successfully updated.'}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin
    authorize! :update, @user

  	if @user.admin == true
  		@user.admin = false
  		@user.save
  		respond_to do |format|
      		format.html { redirect_to admin_path }
    	end
  	else
  		@user.admin = true
  		@user.save
  		respond_to do |format|
      		format.html { redirect_to admin_path }
    	end
  	end 	
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :username)
    end

end
