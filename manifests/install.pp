# Install samba and winbind, and join box to the domain
class winbind::install(
  $packages = $::winbind::packages
){

  # Install samba winbind client
  package { $packages :
    ensure  => installed,
  }

}
