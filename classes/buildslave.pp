# buildslave.pp

### These includes all come from files of the same name
### in the /manifests/packages/ tree

class buildslave {
    case $operatingsystem {
        CentOS: {
            include debuginfopackages
            include devtools
            include nagios
            include scratchbox
            include moz-rpms

        }
        Darwin: {
            include devtools
            include repackaging-tools
            include cacert
        }
    }
}
