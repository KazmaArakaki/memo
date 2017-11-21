# Instruction to install CakePHP 3 on Cent OS 7

## Disable SELINUX

``` sh
$ sudo vim /etc/selinux/config
```

**config**

```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=permissive
```

``` sh
$ sudo reboot
```

## Install required applications

``` sh
$ sudo yum install unzip wget
```

## Install Nginx

``` sh
$ sudo vim /etc/yum.repos.d/nginx.repo
```

**nginx.repo**

```
[nginx]
name=Nginx Repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgkey=http://nginx.org/keys/nginx_signing.key
gpgcheck=1
enabled=1

[nginx-source]
name=Nginx Source
baseurl=http://nginx.org/packages/mainline/centos/7/SRPMS/
gpgkey=http://nginx.org/keys/nginx_signing.key
gpgcheck=1
enabled=0
```

``` sh
$ sudo yum install nginx
```

## Install PHP, PHP-FPM and extensions

``` sh
$ sudo yum install epel-release
$ sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
$ sudo yum install --enablerepo=remi-php71 php php-fpm php-intl php-mbstring php-mysql php-simplexml
```

## Install MySQL (MariaDB)N

``` sh
$ sudo vim /etc/yum.repos.d/mariadb.repo
```

**mariadb.repo**

```
[mariadb]
name=MariaDB
baseurl=http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
```

``` sh
$ sudo yum install mariadb MariaDB-server
```

## Create project directory

``` sh
$ sudo mkdir -p /var/www/cakephp_app
$ sudo cd /var/www/cakephp_app
$ sudo chown kazma:kazma .
```

## Get composer

``` sh
$ wget https://getcomposer.org/composer.phar
$ sudo mv composer.phar /usr/local/bin/composer
$ sudo chmod 744 /usr/local/bin/composer 
```

## Install CakePHP

``` sh
$ composer create-project --prefer-dist cakephp/app .
```

## Configure Nginx

``` sh
$ sudo vim /etc/nginx/conf.d/default.conf
```

**default.conf**

```
server {
  listen 80 default_server;
  server_name localhost_http;
  
  root /var/www/cakephp_app/webroot;
  index index.php index.html;

  location / {
    try_files $uri $uri?$args $uri/ /index.php?$uri&$args /index.php?$args;
  }

  location ~ \.php$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
  }
}
```

``` sh
$ sudo systemctl start nginx
```

## Configure PHP

``` sh
$ sudo vim /etc/php.ini
```

**php.ini** (excerption)

```
;;;;;;;;;;;;;;;;;;;;;;
; Dynamic Extensions ;
;;;;;;;;;;;;;;;;;;;;;;

; If you wish to have an extension loaded automatically, use the following
; syntax:
;
;   extension=modulename.extension
;
; For example, on Windows:
;
;   extension=msql.dll
;
; ... or under UNIX:
;
;   extension=msql.so
;
; ... or with a path:
;
;   extension=/path/to/extension/msql.so
;
; If you only provide the name of the extension, PHP will look for it in its
; default extension directory.
extension=intl.so
```

## Configure PHP-FPM

``` sh
$ sudo vim /etc/php-fpm.d/www.conf
```

**www.conf** (excerption)

```
; Unix user/group of processes
; Note: The user is mandatory. If the group is not set, the default user's group
;       will be used.
; RPM: apache Choosed to be able to access some dir as httpd
user = nginx
; RPM: Keep a group allowed to write in log dir.
group = nginx
```

``` sh
$ sudo systemctl start php-fpm
```

## Configure MySQL (MariaDB)

``` sh
sudo vim /etc/my.cnf.d/server.cnf
```

**server.cnf** (excerption)

```
[mysqld]
character-set-server=utf8
```

``` sh
$ sudo systemctl start mysql
$ mysql_secure_installation
$ mysql -u root -p
```

``` sh
> CREATE USER cake_user IDENTIFIED BY '[PASSWORD]';
> CREATE DATABASE cake_db;
> GRANT ALL PRIVILEGES ON cake_db.* TO cake_user IDENTIFIED BY '[PASSWORD]';
> FLUSH PRIVILEGES;
```

## Configure CakePHP

``` sh
$ vim config/app.php
```

**app.php** (excerption)

``` php
    /**
     * Connection information used by the ORM to connect
     * to your application's datastores.
     * Do not use periods in database name - it may lead to error.
     * See https://github.com/cakephp/cakephp/issues/6471 for details.
     * Drivers include Mysql Postgres Sqlite Sqlserver
     * See vendor\cakephp\cakephp\src\Database\Driver for complete list
     */
    'Datasources' => [
        'default' => [
            'className' => 'Cake\Database\Connection',
            'driver' => 'Cake\Database\Driver\Mysql',
            'persistent' => false,
            'host' => 'localhost',
            /**
             * CakePHP will use the default DB port based on the driver selected
             * MySQL on MAMP uses port 8889, MAMP users will want to uncomment
             * the following line and set the port accordingly
             */
            //'port' => 'non_standard_port_number',
            'username' => 'cake_user',
            'password' => 'twi1ight',
            'database' => 'cake_db',
            'encoding' => 'utf8',
            'timezone' => 'UTC',
            'flags' => [],
            'cacheMetadata' => true,
            'log' => false,
            
            /**
             * Set identifier quoting to true if you are using reserved words or
             * special characters in your table or column names. Enabling this
             * setting will result in queries built using the Query Builder having
             * identifiers quoted when creating SQL. It should be noted that this
             * decreases performance because each query needs to be traversed and
             * manipulated before being executed.
             */
            'quoteIdentifiers' => false,
            
            /**
             * During development, if using MySQL < 5.6, uncommenting the
             * following line could boost the speed at which schema metadata is
             * fetched from the database. It can also be set directly with the
             * mysql configuration directive 'innodb_stats_on_metadata = 0'
             * which is the recommended value in production environments
             */
            //'init' => ['SET GLOBAL innodb_stats_on_metadata = 0'],
            'url' => env('DATABASE_URL', null),
        ],
        
        /**
         * The test connection is used during the test suite.
         */
        'test' => [
            'className' => 'Cake\Database\Connection',
            'driver' => 'Cake\Database\Driver\Mysql',
            'persistent' => false,
            'host' => 'localhost',
            //'port' => 'non_standard_port_number',
            'username' => 'cake_user',
            'password' => 'twi1ight',
            'database' => 'cake_db',
            'encoding' => 'utf8',
            'timezone' => 'UTC',
            'cacheMetadata' => true,
            'quoteIdentifiers' => false,
            'log' => false,
            //'init' => ['SET GLOBAL innodb_stats_on_metadata = 0'],
            'url' => env('DATABASE_TEST_URL', null),
        ],
    ],
```
