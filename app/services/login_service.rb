class LoginService

  def initialize(username)
    @adapter = Auth::Ldap.new
    @dn = @adapter.search(username)
  end

  def authenticate(password)
    @adapter.verify @dn, password
  end

end
