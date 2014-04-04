## Security Token Service (STS) made simple

A Security Token Service is a software based identity provider responsible for issuing security tokens, especially software tokens, as part of a claims-based identity system.

In a typical usage scenario, a client requests access to a secure software application, often called a relying party. Instead of the application authenticating the client the client is redirected to an STS. The STS authenticates the client and issues a security token. Finally, the client is redirected back to the relying party and present the security token. The token is the data record in which claims are packed. The token is protected from tinkering with strong cryptology. The software application verifies that the token originated from a STS trusted by it, and then makes authorization decisions accordingly. The token is creating a chain of trust between the STS and the software application consuming the claims.

By default this STS enable ldap, which you can configure with your data in config/config.yml

## Restful endpoints:

Obtaining a token:

* POST /tokens/:provider

with params 'username' and 'password', where provider is the OmniAuth provider you specify inside config/initializer/omniauth.rb.
Read: https://github.com/intridea/omniauth/wiki/List-of-Strategies for a list of authentication strategies.

Verify a token:

* GET /tokens
  * GET tokens | with http header 'Authorization' 'token 124CB20EAE70471CB5457961E15661F0'
  * GET tokens/iHi56sesgI5wiGoF1s-zZA
  * GET tokens?token=iHi56sesgI5wiGoF1s-zZA

Listing configured strategies:

* GET /tokens/new

```
{ "strategies" : [ "LDAP", "Developer" ] }
```

