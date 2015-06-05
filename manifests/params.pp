# Install samba and winbind, and join box to the domain
class winbind::params {

  $domainadminuser = 'admin'
  $domainadminpw   = 'domainadminpw'
  $domain          = 'MYCOMPANY'
  $realm           = 'ads.mycompany.org'
  $netbiosname = $::netbiosname
  $winbind_max_domain_connections = 1
  $winbind_max_clients = 200
  $packages = ['samba-winbind-clients','samba-winbind','samba-client']
  $smb_template = 'winbind/smb.conf.erb'
  $service = 'winbind'

}
