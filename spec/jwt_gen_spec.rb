require_relative '../lib/jwt_gen'

describe JwtGen do

    it "has a version number" do
        expect(JwtGen::VERSION).not_to be nil
    end

    describe 'generate' do
    before do
       @app = JwtGen::App.new(email: 'bob@foo.com', user_id: 1, secret: '1234')
    end


    it 'accepts the right parameters' do
        expect(@app.email).to eq('bob@foo.com')
        expect(@app.user_id).to eq(1)
        expect(@app.secret).to eq('1234')
    end

    it "generates a json web token string" do
        expect(@app.call.class).to eq(String)
    end

    it "correctly generates a web token" do
        token = @app.call
        decoded = JWT.decode(token, '1234', true, { :algorithm => 'HS256' })[0]
        expect(decoded).to eq({"email" => "bob@foo.com", "user_id" => 1})
    end
    end

    describe 'extras' do
        before do
            @app = JwtGen::App.new(email: 'foo@bar.com', user_id: 1, secret: '123', extras: {admin: false})
            @token = @app.call
        end

        it "accepts extra paramters" do
            expect(@app.extras).to eq({admin: false})
        end

        it "properly encodes extras" do
            decoded = JWT.decode(@token, '123', true, { :algorithm => 'HS256'})[0]
            expect(decoded).to eq({"email" => "foo@bar.com", "user_id" => 1, "admin" => false})
        end

        it "properly handles nil extras" do
            app = JwtGen::App.new(email: 'foo@bar', user_id: 1, secret: '123', extras: nil)
            expect(app.extras).to eq({})
            expect(app.call.class).to eq(String)
        end
    end

    describe 'clipboard' do
        before do
            @app = JwtGen::App.new(secret: '123', user_id: 1, email: 'bob@bob.com')
        end

        it 'should copy the token to the clipboard' do
            @app.call
            expect(Clipboard.paste).to eq(@app.token)
        end
    end
end
