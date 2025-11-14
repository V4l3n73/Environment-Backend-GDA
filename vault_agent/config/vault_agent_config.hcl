pid_file = "./pidfile"
vault {
  address = "http://vault:8200"
  retry {
    num_retries = 5
  }
}
auto_auth {
  method {
    type = "approle"
      config = {
        role_id = "Aqui va el role id inyectado por jenkins"
        secret_id = "Aqui va el secret id inyectado por jenkins"
     }
  }
  sink "file" {
    config = {
      path = "/vault/secrets/sink_file.tmp"
    }
  }
}
template {
  source      = "/vault/templates/template.ctmpl"
  destination = "/secrets_extracted/env-vars"
  perms = 0755
  command = "touch /secrets_extracted/env-ready"
}
template {
  source      = "/vault/templates/dotnet-template.ctmpl"
  destination = "/secrets_extracted/dotnet-vars.env"
  perms = 0644
  command = "touch /secrets_extracted/dotnet-env-ready"
}