# Install samba and winbind, and join box to the domain
class winbind::config (
  $smb_template    = $::winbind::smb_template,
  $domainadminuser = $::winbind::domainadminuser,
  $domainadminpw   = $::winbind::domainadminpw,
  $domain          = $::winbind::domain,
  $netbiosname     = $::winbind::netbiosname,
  $realm           = $::winbind::realm
) {

  $upcase_domain=upcase($realm)

  # Main samba config file
  file { 'smb.conf':
    name    => '/etc/samba/smb.conf',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template($smb_template),
  }

  # Authconfig
  exec { 'authconfig-krb5':
    command => "authconfig --disablecache --enablewinbind --enablewinbindauth --smbsecurity=ads --smbworkgroup=$domain --smbrealm=$upcase_domain --enablewinbindusedefaultdomain --winbindtemplatehomedir=/home/%U --winbindtemplateshell=/bin/bash --enablekrb5 --krb5realm=$upcase_domain --enablekrb5kdcdns --enablekrb5realmdns --enablelocauthorize --enablemkhomedir --enablepamaccess --updateall",
    onlyif  => "wbinfo --own-domain | grep -v ${domain}",
    path => $path,
    require => File['smb.conf'],
    
  }

  # Add the machine to the UOB domain
  exec { 'add-to-domain':
    command => "net ads join -U ${domainadminuser}%${domainadminpw}",
    onlyif  => "wbinfo --own-domain | grep -v ${domain}",
    path    => '/bin:/usr/bin',
    require => Exec['authconfig-krb5']
  }

}
