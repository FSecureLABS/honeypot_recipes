#
# Cookbook Name:: sysdig-falco
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


case node['platform']
when 'ubuntu', 'debian'

#Trust the Draios GPG key
	execute 'add-key' do
	  command 'curl -s https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public | apt-key add -'
	end

#configure the apt repository
	execute 'config-repo' do
	  command 'curl -s -o /etc/apt/sources.list.d/draios.list http://download.draios.com/stable/deb/draios.list'
	end

#update the package list
	execute 'update-package-list' do
	  command 'apt-get update'
	  ignore_failure true
	end

#install the appropriate linux headers
	execute 'install-linux-headers' do
	  command 'apt-get -y install linux-headers-$(uname -r)'
	end

#install falco
	apt_package 'falco' do
	  action :install
	end

#start falco service
	execute 'start falco service' do
	  command 'service falco start'
	end

#create init file for sysdig
	 template '/etc/init.d/mysysdig' do
	  source 'mysysdig.erb'
	  owner 'root'
	  group 'root'
	  mode '0755'
	end

#start sysdig as a service
	service 'mysysdig' do
	  action :start
	end

when 'redhat', 'centos'

#Trust the Draios GPG key
	execute 'add-key' do
	  command 'rpm --import https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public'
	end

#configure the apt repository
	execute 'config-repo' do
	  command 'curl -s -o /etc/yum.repos.d/draios.repo http://download.draios.com/stable/rpm/draios.repo'
	end

#add epel repository
	execute 'add-epel-repo' do
	  command 'rpm -i http://mirror.us.leaseweb.net/epel/6/i386/epel-release-6-8.noarch.rpm'
	  ignore_failure true
	end

#install the appropriate linux headers
	execute 'install-linux-headers' do
	  command 'yum -y install kernel-devel-$(uname -r)'
	end

	%w{falco psmisc}.each do |pkg|
	  yum_package pkg do
	    action :install
	  end
	end

#start falco service
	service 'falco' do
          action [:enable, :start]
        end

#create init file for sysdig
	template '/etc/init.d/mysysdig' do
          source 'mysysdig.erb'
          owner 'root'
          group 'root'
          mode '0755'
	end

#start sysdig as a service
	service 'mysysdig' do
          action :start
	end

when 'fedora'

#Trust the Draios GPG key
	execute 'add-key' do
          command 'rpm --import https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public'
        end

#configure the apt repository
	execute 'config-repo' do
          command 'curl -s -o /etc/yum.repos.d/draios.repo http://download.draios.com/stable/rpm/draios.repo'
        end

#install the appropriate linux headers
	execute 'install-linux-headers' do
          command 'yum -y install kernel-devel-$(uname -r)'
        end

#install falco and psmisc
	execute 'install-falco-psmisc' do
	  command 'dnf install falco psmisc -y'
	end

#start falco service
        service 'falco' do
          action [:enable, :start]
        end

#create init file for sysdig
        template '/etc/init.d/mysysdig' do
          source 'mysysdig.erb'
          owner 'root'
          group 'root'
          mode '0755'
        end

#start sysdig as a service
        service 'mysysdig' do
          action :start
        end

end
