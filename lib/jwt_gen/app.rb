require 'jwt'
require 'clipboard'

module JwtGen
    class App
        attr_reader :secret, :email, :user_id, :extras, :token

        def initialize(secret:, user_id:, email:, extras: {})
            @secret = secret
            @user_id = user_id
            @email = email
            @extras = extras || {}
        end

        def call
                token = generate_token
                Clipboard.copy(token)
            token
        end

        private

        def payload
            {
                email: @email,
                user_id: @user_id
            }.merge(extras)
        end

        def generate_token
            @token ||= JWT.encode(payload, secret, 'HS256')
        end
    end
end
