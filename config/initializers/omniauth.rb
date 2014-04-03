Rails.application.config.middleware.use OmniAuth::Builder do

  configure do |config|
    config.path_prefix = '/tokens'
    config.allowed_request_methods = [ :get ]
    # config.before_callback_phase {}
  end

  # Use any provider you want, choose from: https://github.com/intridea/omniauth/wiki/List-of-Strategies
  provider :developer, :callback_path => '/tokens/developer' unless Rails.env.production?

  provider :LDAP,
           :title => 'LDAP Login',
           :host => APP_CONFIG['ldap_server'],
           :port => APP_CONFIG['ldap_port'],
           :method => :plain,
           :base => APP_CONFIG['root'],
           :uid => 'sAMAccountName',
           :name_proc => Proc.new { |name| name.gsub(/@.*$/,'') },
           :try_sasl => false,
           :sasl_mechanisms => [ 'GSS-SPNEGO' ],
           :bind_dn => APP_CONFIG['bind_user'],
           :password => APP_CONFIG['bind_password'],
           :callback_path => '/tokens/ldap'

end
