class AuthenticationController < ApplicationController
    before_action :authorize_request, except: %i[login register]

    # POST /auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 6.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                        user: @user
                        }, status: :ok

        else
            render json: { error: 'Invalide email or password' }, status: :unprocessable_entity
        end
    end

     # POST /auth/register
     def register
        user = User.find_by_email_or_username(params[:email], params[:username])
        if !user
            if @user = User.create(register_params)
                token = JsonWebToken.encode(user_id: @user.id)
                time = Time.now + 6.hours.to_i
                render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                                user: @user
                                }, status: :ok
            else
                render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            end

        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    private

    def login_params
        params.permit(:email, :password)
    end

    def register_params
        params.permit(:name, :username, :email, :password, :password_confirmation)
    end

end
