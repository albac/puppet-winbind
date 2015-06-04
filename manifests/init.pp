# Install samba and winbind, and join box to the domain
class winbind (
  $packages        = $::winbind::params::packages,
  $service         = $::winbind::params::service,
  $domainadminuser = $::winbind::params::domainadminuser,
  $domainadminpw   = $::winbind::params::domainadminpw,
  $domain          = $::winbind::params::domain,
  $realm           = $::winbind::params::realm,
  $netbiosname     = $::winbind::params::netbiosname,
  $winbind_max_domain_connections = $::winbind::params::winbind_max_domain_connections,
  $winbind_max_clients = $::winbind::params::winbind_max_clients,
) inherits winbind::params {

  anchor { '::winbind::start': } ->
  class { '::winbind::install': } ->
  class { '::winbind::config': } ~>
  class { '::winbind::service': } ->
  anchor { '::winbind::end': }

}
