class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def counts(user)
        @count_recipes = user.recipes.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
    end

    private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:username])
    end
    

    
end
