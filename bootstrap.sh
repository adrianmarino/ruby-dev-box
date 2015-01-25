###############################################################################
# Functions
###############################################################################
function install {
    echo "Installing $1"
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}
#
#
#
###############################################################################
# Main
###############################################################################
echo "APT update"
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'Development tools' build-essential

install "Git" git
install "SQLite" sqlite3 libsqlite3-dev

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install "MySQL" mysql-server mysql-client libmysqlclient-dev

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'NodeJS runtime' nodejs

echo "Setup System Language"
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo "RVM"
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --rails

install "Vim" vim

echo 'Enjoy!'
