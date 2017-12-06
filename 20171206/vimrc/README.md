``` vim
Last login: Tue Dec  5 19:45:04 on ttys003
~ $ cd Share/reservia2/
reservia2 $ ls
reservia2 $ ls
reservia2 $ cd ..
Share $ ls
reservia2
Share $ vim connect.sh
Share $ ls -la
total 24
drwxr-xr-x   5 arakaki  staff   160 12  6 10:02 .
drwxr-xr-x+ 32 arakaki  staff  1024 12  6 10:02 ..
-rw-r--r--@  1 arakaki  staff  6148 12  6 09:55 .DS_Store
-rw-r--r--   1 arakaki  staff   155 12  6 10:02 connect.sh
drwxr-xr-x   2 arakaki  staff    64 12  5 11:58 reservia2
Share $ chmod 744 connect.sh 
Share $ ls -la
total 24
drwxr-xr-x   5 arakaki  staff   160 12  6 10:02 .
drwxr-xr-x+ 32 arakaki  staff  1024 12  6 10:02 ..
-rw-r--r--@  1 arakaki  staff  6148 12  6 09:55 .DS_Store
-rwxr--r--   1 arakaki  staff   155 12  6 10:02 connect.sh
drwxr-xr-x   2 arakaki  staff    64 12  5 11:58 reservia2
Share $ connect
-bash: connect: command not found
Share $ ./connect
-bash: ./connect: No such file or directory
Share $ connect.sh
-bash: connect.sh: command not found
Share $ ./connect.sh
Share $ ls reservia2/
pomerge	sql	src	www
Share $ mkdir connect
Share $ mv connect.sh connect
Share $ mv connect/connect.sh connect/reservia2
Share $ ssh reservia2
Last login: Wed Dec  6 09:57:37 2017 from 58x80x200x14.ap58.ftth.ucom.ne.jp

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-ami/2015.09-release-notes/
84 package(s) needed for security, out of 197 available
Run "sudo yum update" to apply all updates.
Amazon Linux version 2017.09 is available.
[~ ]$ ls -la
合計 116
drwxr-xr-x 9 arakaki arakaki  4096 12月  5 16:44 .
drwxr-xr-x 9 root    root     4096 11月 27 01:59 ..
-rw-r--r-- 1 arakaki arakaki  6148 12月  5 16:34 .DS_Store
-rw-r--r-- 1 arakaki arakaki  4096 12月  5 12:04 ._.DS_Store
-rw------- 1 arakaki arakaki  9905 12月  6 09:58 .bash_history
-rw-r--r-- 1 arakaki arakaki    18  9月  3  2015 .bash_logout
-rw-r--r-- 1 arakaki arakaki   215 11月 29 10:17 .bash_profile
-rw-r--r-- 1 arakaki arakaki   124  9月  3  2015 .bashrc
-rw-rw-r-- 1 arakaki arakaki    68 11月 28 16:33 .gitconfig
-rw------- 1 arakaki arakaki 19650 12月  5 16:35 .mysql_history
drwxrw---- 3 arakaki arakaki  4096 11月 28 17:51 .pki
drwxr-xr-x 2 arakaki arakaki  4096 11月 27 02:29 .ssh
drwxrwxr-x 4 arakaki arakaki  4096 12月  5 15:15 .vim
-rw------- 1 arakaki arakaki  9776 12月  5 16:44 .viminfo
-rw-rw-r-- 1 arakaki arakaki   624 11月 29 18:56 .vimrc
-rw-rw-r-- 1 arakaki arakaki   182 11月 28 17:56 .wget-hsts
drwxr-xr-x 2 arakaki arakaki  4096 12月  5 19:51 pomerge
drwxrwxr-x 2 arakaki arakaki  4096 12月  5 15:04 sql
drwxrwxr-x 3 arakaki arakaki  4096 12月  5 15:38 src
drwxr-xr-x 2 arakaki arakaki  4096 11月 27 17:56 www
[~ ]$ vim .vimrc
[~ ]$ less .vimrc

map <C-k> <C-w>k
map <C-l> <C-w>l

autocmd QuickFixCmdPost *grep* cwindow

" ==========
" NeoBundle Setting
" ==========

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'mattn/emmet-vim'

call neobundle#end()
NeoBundleCheck

" ==========

syntax on
color dracula
```
