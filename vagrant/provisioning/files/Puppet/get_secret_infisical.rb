Puppet::Functions.create_function(:'infisical::get_secret') do
    dispatch :get_secret do
      param 'String', :secret_key
    end

    def get_secret(secret_key)
      `infisical secrets get {secret_key}`.strip
    end
  end