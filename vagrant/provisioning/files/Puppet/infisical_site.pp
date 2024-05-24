node 'test-agent' {
    $secret_key = 'PUPPET_INJECTION' # Kies de secret om op te halen
    $secret_value = infisical::get_secret($secret_key) # Voer de Ruby functie uit

    # Schrijf een file weg met de opgehaalde secret
    file { '/tmp/infisical_secret.txt': 
    ensure  => file,
    content => "De secret is: ${secret_value}",
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    }
} 