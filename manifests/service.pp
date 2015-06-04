# Install samba and winbind, and join box to the domain
class winbind::service {

  # Start the winbind service
  service { $::winbind::service :
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
