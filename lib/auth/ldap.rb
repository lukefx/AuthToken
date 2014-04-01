module Auth

  class Ldap

    attr_accessor :options

    def initialize(options={})
      @options = {}.merge(options)
    end

    def search(username)

      ldap = Net::LDAP.new
      ldap.host = APP_CONFIG['ldap_server']
      ldap.port = APP_CONFIG['ldap_port']
      ldap.auth APP_CONFIG['bind_user'], APP_CONFIG['bind_password']
      treebase = APP_CONFIG["root"]

      filter = Net::LDAP::Filter.eq('sAMAccountName', "*#{username}*") |
          Net::LDAP::Filter.eq('displayName', "*#{username}*")    |
          Net::LDAP::Filter.eq('sn', "*#{username}*")             |
          Net::LDAP::Filter.eq('givenName', "*#{username}*")

      final_filter = filter & Net::LDAP::Filter.eq('objectCategory', 'person')

      if ldap.bind
        ldap.search(:base => treebase, :filter => filter) do |object|
          return object.dn
        end
      else
        return nil
      end

    end

    def verify(credential, password)
      ldap = Net::LDAP.new
      ldap.host = APP_CONFIG['ldap_server']
      ldap.port = APP_CONFIG['ldap_port']
      ldap.auth credential, password
      ldap.bind rescue false
    end

  end

end
