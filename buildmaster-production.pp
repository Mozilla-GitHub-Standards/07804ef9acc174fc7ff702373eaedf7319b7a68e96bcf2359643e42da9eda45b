# top level manifest for buildbot master puppet master
# symlink as site.pp, or set manifests = buildmaster-production.pp in
# puppet.conf

# For passwords, etc.
import "secrets.pp"

$puppetServer = "master-puppet1.build.mozilla.org"
$level = "production"
$httproot = "http://${puppetServer}/${level}"

# disable filebuckets - we do not want to keep copies of files that
# puppet overwrites
File { backup => false }

node "master" {
    # This is required by the packages::install_rpm define
    # It would be nice to include packages from define itself, but this
    # sometimes leads to dependency cycles, which as near as I (catlee) can
    # tell, are caused by http://projects.puppetlabs.com/issues/2423.
    # This is supposedly fixed in puppet 0.25, so worth revisiting this once we
    # upgrade
    include packages
}

node "buildbot-master04.build.scl1.mozilla.com" inherits "master" {
    $num_masters = 1
    buildmaster::buildbot_master {
        "bm04-tests1":
            http_port => 8201,
            master_type => "tests",
            basedir => "tests1";
    }
}

node "buildbot-master06.build.scl1.mozilla.com" inherits "master" {
    $num_masters = 1
    buildmaster::buildbot_master {
        "bm06-tests1":
            http_port => 8201,
            master_type => "tests",
            basedir => "tests1";
    }
}
