require_relative '../lib/app'

describe JwtGen do
    it 'accepts the right parameters' do
        app = JwtGen.new(email: 'bob@foo.com', user_id: 1, secret: '1234')
        expect(app.email).to eq('bob@foo.com')
        expect(app.user_id).to eq(1)
        expect(app.secret).to eq('1234')
    end
end
