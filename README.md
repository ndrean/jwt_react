# JwtReact

[Source](https://njwest.medium.com/jwt-auth-with-an-elixir-on-phoenix-1-3-guardian-api-and-react-native-mobile-app-1bd00559ea51)

mix phx.gen.json Accounts User users email:unique password_hash:string

The virtual:true fields are never saved on our server, they only accept the password and password_confirmation logic that our Phoenix app encrypts into our user’s password_hash.

## Rules

[Secure & scale](https://fusionauth.io/learn/expert-advice/ciam/making-sure-your-auth-system-scales)

> use performant password hashing ([Comeonin with argon)(<https://hexdocs.pm/comeonin/readme.html#password-hashing-libraries>))
> rate limiter. You can rate limit at the network layer using an ACL or a CDN, by using a proxy, such as nginx, in front of your auth system, or inside the auth system itself: [Hammer](https://github.com/ExHammer/hammer).
> since you need to fetch the password hash in the database, you might need "read replicas" or "sharding" (eg depending on first letter A-M and N-Z, or on location).
> caching user sessions with Redis.
> if your app is distributed or micro-services, then the authentication might become a bottleneck since every request must be authenticated through the authentication process. Instead of sessions, you can use JWT tokens.

## Notes: session vs token

[Article](https://sherryhsu.medium.com/session-vs-token-based-authentication-11a6c5ac45e4)
