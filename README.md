Overview
========

TODO's
======

* Enable passwordless `vagrant` SSH account
	- [http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker](Cannot access Centos sshd on Docker)
	- [OpenSSH Problem (@the bottom)](http://grid.ncsa.illinois.edu/ssh/ts_server.html)
	- [How OpenSSH checks for locked Linux accounts](https://www.rodneybeede.com/How_OpenSSH_checks_for_locked_Linux_accounts.html)
* Volume mounting
	- [Running Syslog Within a Docker Container](http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/)
* Chef SSL validation (Needs Certificate!)
* Make sure chef-repo is up to date before uploading it to the server (install git, git pull...)
* Do something against warning like "warning: /var/cache/yum/x86_64/7/updates/packages/tzdata-2014j-1.el7_0.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY"

Usage
=====

* Install VirtualBox
* Install Vagrant
* Open Shell
* Navigate to Folder
* Enter `vagrant up` and wait...
	- This command will configure and boot the host VM



Machines
========

* `host` - The host VM containing all Docker Containers and the Open Source Chef-Server.
* `local-workstation` - Workstation to work locally on Chef recipes and e.g. upload it to the local Chef-Server.
* `remote-workstation` - Workstation to work on Chef-Recipes and e.g. upload it to the remote Chef-Server.
* `jenkins` - 

Network
=======

* Hostname: `host` 
	- Type: `Virtual Machine`
	- Private-IP: `192.168.7.1`
	- Services:
		- Chef-Server
	- Forworded Ports:
	<table>
		<tr><th>**Guest**</th>		<th>**Host**</th>		<th>**Description**</th></tr>
		<tr><td>80</td>				<td>9090</td>			<td>Chef-Server UI HTTP</td></tr>
		<tr><td>443</td>			<td>9191</td>			<td>Chef-Server UI HTTPS</td></tr>
	</table>
	- Containers:
		* Hostname: `chef-workstation` 
			- Type: `Docker Container`
			- Private-IP: `192.168.7.2`
			- Services:
				- None
			- Ports:
				- None
		* Hostname: `jenkins` 
			- Type: `Docker Container`
			- Private-IP: `TODO`
			- Services:
				- Jenkins CI
			- Ports:
			<table>
				<tr><th>**Port**</th>		<th>**Description**</th></tr>
				<tr><td>8080</td>			<td>Jenkins UI HTTP</td></tr>
				<tr><td>8181</td>			<td>Jenkins UI HTTPS</td></tr>
			</table>

Further Reading
===============

* [SSHD_Config (Deutsche Erklärung)](http://www.debianroot.de/server/sshd_config-1097.html)
* [Vagrant Chef Solo & Client Properties](http://docs.vagrantup.com/v2/provisioning/chef_common.html)
* [chef-server.rb optional settings](https://docs.getchef.com/config_rb_chef_server_optional_settings.html)
* [Chef Server Configuration](https://www.getchef.com/blog/2013/03/11/chef-11-server-up-and-running/)