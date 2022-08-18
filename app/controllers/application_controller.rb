class ApplicationController < ActionController::API
    before_action :require_login

    def jwt_key
        Rails.application.secrets.secret_key_base
    end

    def encode_token(payload)
        JWT.encode(payload, jwt_key, 'HS256')
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, jwt_key, true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end

    end

    def current_user

        if decoded_token

            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)

        end
    end

    def logged_in?
        !!current_user  # ruby object/class instance is 'truthy'
    end

    def require_login
        render json: {message: 'Please Login or Sign up'}, status: :unauthorized unless logged_in?
    end
end
