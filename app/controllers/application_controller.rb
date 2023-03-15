class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    # jwt authentication
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, 'my_s3cr3t')
    end

    def auth_header
        request.headers['Authorization']
    end

    # check if the token is valid and if the authorization header is present

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end

    end

    # find current user if the token is valid

    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end

    end

    # check if the user is logged in

    def logged_in?
        !!current_user
    end

    # if the user is not logged in, send a message to log in

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

    private



end
