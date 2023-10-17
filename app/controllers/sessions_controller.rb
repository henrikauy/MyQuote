class SessionsController < ApplicationController
    def new
    end

    def create
        # Find user by email
        user = User.find_by(email: params[:email])
        # If the user and password combination is correct
        if user && user.authenticate(params[:password])
            # Check if user is active
            if user.status == "Active"
                # Store user info in session
                session[:user_id] = user.id
                session[:fname] = user.fname
                session[:is_admin] = user.is_admin

                # Redirect to either admin homepage or standard user homepage
                if session[:is_admin]
                    redirect_to admin_path, notice: "Logged in successfully!"
                else
                    redirect_to userhome_path, notice: "Logged in successfully!"
                end
            elsif user.status == "Suspended"
                # Display an error if user is suspended
                flash.now[:error] = "Your account is suspended."
                render 'new'
            elsif user.status == "Banned"
                # Display an error if user is banned
                flash.now[:error] = "Your account is banned."
                render 'new'
            end
        else
            # Display an error if login fails
            flash.now[:error] = "Invalid email or password. Please try again."
            render 'new'
        end
    end
        
    def destroy
        # Clear the user's session on logout
        session[:user_id] = nil
        # Go to home page
        redirect_to root_path, notice: "Logged out successfully!"
    end

end