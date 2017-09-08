require 'jwt'

module JwtGen
    class App
        attr_reader :secret, :email, :user_id, :extras

        def initialize(secret:, user_id:, email:, extras: {})
            @secret = secret
            @user_id = user_id
            @email = email
            @extras = extras || {}
        end

        def call
            generate_token 
        end

        private

        def payload
            {
                email: @email,
                user_id: @user_id
            }.merge(extras)
        end

        def generate_token
            JWT.encode(payload, secret, 'HS256')
        end
    end
end