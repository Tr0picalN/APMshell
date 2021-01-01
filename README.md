## Projectstart

2020-06-30

## Used

APM ver.

httpd-2.4.43.tar.gz
mysql-5.6.47.tar.gz
php-5.5.17.tar.gz

## Author

Tr0picalN

## How to use

설치후 Quota준비와 NoInetYum 준비

httpd-2.4.43.tar.gz
mysql-5.6.47.tar.gz
php-5.5.17.tar.gz
위파일들을
/usr/local/src/ 에 옮기고
압축풀기

APM 설치실행 & ftp설치 실행
oneclick.sh 실행
권한오류시 chmod 755로 권한줌
자동으로 설치완료

usr/local/apache/bin 안에 들어가 ./apachectl restart

apache서버 구동후 localhost/phpinfo.php 로 php설치 확인가능

/usr/local/mysql/bin 안에서 ./mysql 으로 mysql 실행
