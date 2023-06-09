# nginx_uwsgi_flask_fedora
Serve up multiple Flask apps using uWSGI emperor and nginx. Configuration for Fedora OS

## Examples

Example of uwsgi serving up a simple Flask app

`. ./setup.sh`

`./run_server_example.sh`

## Notes

[uWSGI Quickstart](https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html)

[Configuring Nginx](https://chriswarrick.com/blog/2016/02/10/deploying-python-web-apps-with-nginx-and-uwsgi-emperor/)

[SELinux](https://medium.com/@getpagespeed/nginx-selinux-configuration-74938ef08670)

CHECK LOCAL DIRECTORIES FOR STALE .INI AND .CONF FILES!!! THESE MAY CONFLICT

## Debug Commands

`sudo tail -f /var/log/nginx/error.log`

`sudo curl -v --unix-socket /srv/flaskappdata/uwsgi.sock http`

`sudo systemctl restart uwsgi.service nginx.service`

### Handling SELinux

`sudo semanage permissive -a httpd_t`

`sudo grep nginx /var/log/audit/audit.log | audit2allow -m nginx`

Copy/Paste that output into a .te file such as the ones in SELinux

Bring shields back up

`sudo semanage permissive -d httpd_t`
