name 'golob-taskmanager'
maintainer 'FredHutch Scientific Computing'
maintainer_email 'mrg@fredhutch.org'
license 'All Rights Reserved'
description 'Installs/Configures golob-taskmanager'
long_description 'Installs/Configures golob-taskmanager'
version '0.2.2'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'ubuntu'

issues_url 'https://github.com/fredhutch/golob-taskmanager/issues'
source_url 'https://github.com/fredhutch/golob-taskmanager'

depends 'nginx', '~>7.0.2'
depends 'chef-vault'
depends 'poise-python'
depends 'airflow', '~> 1.2.1'
