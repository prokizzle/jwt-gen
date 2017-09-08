# JwtGen

Generate a JWT token including a user email, user id, and any other paramters

## Setup

```
bundle install
```

## Usage

```
ruby bin/jwt-gen -h
ruby bin/jwt-gen -v
ruby bin/jwt-gen generate $secretKey --email=foo@bar.com --user-id=1 --extra-params="{\"admin\":true}"
# => fdlmkgsdkfm435klqmfdsa9gdr034qtklmsdflk0
```
