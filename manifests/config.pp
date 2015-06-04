# Install samba and winbind, and join box to the domain
class winbind::config (
  $smb_template    = $::winbind::smb_template,
  $domainadminuser = $::winbind::domainadminuser,
  $domainadminpw   = $::winbind::domainadminpw,
  $domain          = $::winbind::domain,
  $netbiosname     = $::winbind::netbiosname,
  $realm           = $::winbind::realm
) {

  # Main samba config file
  file { 'smb.conf':
    name    => '/etc/samba/smb.conf',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template($smb_template),
  }

  # Add the machine to the UOB domain
  exec { 'add-to-domain':
    command => "net ads join -U ${domainadminuser}%${domainadminpw}",
    onlyif  => "wbinfo --own-domain | grep -v ${domain}",
    path    => '/bin:/usr/bin',
    require => File['smb.conf'],
  }

}
