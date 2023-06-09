all: build_venv setup_system_deps install_files create_policies enable_services

build_venv:
	# Create venv if it does not exist
	if [ ! -d "venv" ]; then \
		python3 -m venv venv; fi

	source venv/bin/activate; \
	pip install --upgrade pip; \
	pip install wheel; \
	pip install flask;

setup_system_deps:

	# Install uwsgi if it does not exist
	if ! rpm -q uwsgi > /dev/null 2>&1; then \
		echo "uwsgi package is not installed"; \
		sudo dnf install -y uwsgi uwsgi-plugin-python3 uwsgi-logger-file; fi

	# Install nginx if it does not exist
	if ! rpm -q nginx > /dev/null 2>&1; then \
		echo "nginx package is not installed"; \
		sudo dnf install -y nginx; fi

install_files:
	sudo mkdir -p /srv/flaskappdata/apps/
	sudo cp apps/*.ini /etc/uwsgi.d/
	sudo cp apps/*.py /srv/flaskappdata/apps/
	sudo cp config/*.conf /etc/nginx/conf.d/
	sudo cp config/uwsgi.ini /etc/
	sudo cp -r apps/static /srv/flaskappdata/apps/
	sudo cp -r venv /srv/flaskappdata/
	sudo chown -R uwsgi:nginx /srv/flaskappdata

create_policies:
	cd SELinux; \
	./compile_create_load; \
	cd -;

enable_services:
	if systemctl is-active httpd; then \
		sudo systemctl disable httpd --now; fi
	sudo systemctl enable nginx uwsgi --now

restart:
	sudo systemctl restart nginx uwsgi

run_example:
	cd apps; \
	uwsgi --ini flask_app0.ini; \

uninstall:
	sudo dnf remove -y nginx uwsgi uwsgi-plugin-python3 uwsgi-logger-file
	sudo rm -rf /srv/flaskappdata
	sudo rm -rf venv