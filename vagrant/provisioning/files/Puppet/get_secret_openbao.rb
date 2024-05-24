Puppet::Functions.create_function(:'openbao::get_secret') do
    dispatch :get_secret do
      param 'String', :secret_path
    end
  
    def get_secret(secret_path)
      `bao kv get -field=value #{secret_path}`.strip # Voeg strip toe voor correcte parsing
    end
  end