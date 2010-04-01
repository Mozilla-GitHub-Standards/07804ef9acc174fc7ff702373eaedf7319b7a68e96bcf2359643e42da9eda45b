# staging-buildslave.pp

### These includes all come from files of the same name
### in the /manifests/packages/ tree

class staging-buildslave {
    case $operatingsystem {
        CentOS: {
            include debuginfopackages
            include devtools
            include nagios
            include scratchbox
            include mercurial
            include buildbot
            include moz-rpms

            file {
                "/etc/sysconfig/puppet":
                    source => "${fileroot}centos5/etc/sysconfig/puppet-staging",
                    owner => "root",
                    group => "root";
            }
        }
        Darwin: {
            include devtools
            file {
                "/Library/LaunchDaemons/com.reductivelabs.puppet.plist":
                    source => "${fileroot}darwin9/com.reductivelabs.puppet.plist-staging",
                    owner => "root",
                    group => "wheel",
                    require => file["/etc/fstab"];    
            }
        }
    }
}
