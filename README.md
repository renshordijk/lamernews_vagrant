# Description
A high available Lamernews deployment using Vagrant

# About
This is a lamernews deployment using Vagrant and Saltstack. Vagrant takes care of the infrastructure (creation of servers) and Saltstack takes care of the system packages and other configuration steps needed to create a working environment.

# Installation
To use this installation, a few simple steps are needed:

1. Make sure you have Vagrant installed on your computer (ie. apt-get install vagrant on Debian systems)
2. Clone this repository
3. Enter the directory and type "vagrant up"

After these steps are done, Vagrant will deploy seven VM's (lb1, lb2, app1, app2, db1, db2 and db3).

# System requirements
1. Make sure you have at lease 2 GB free memory on your system.
2. Make sure you are not using the ip ranges 10.10.1.0/24, 10.10.2.0/24, 10.10.3.0/24. These are used by Vagrant, and IP conflicts should be avoided.

# Usage
When everything is up and running, the following URL's are available to see the results:

##HAproxy status
Here you can find the status of HAproxy on both of the loadbalancers.

LB1: http://10.10.1.10:8888/
LB2: http://10.10.1.11:8888/

##Loadbalanced application
The application is available at: http://10.10.1.100

# The set-up explained

## LB's
The LB VM's are loadbalancers, and are using keepalived and HAproxy. Keepalived takes care of the VIP adresses (for the main site URL and the database VIP the app's are using) to be present on one of the two VM's. HAproxy loadbalances the traffic to the application servers and also the Redis database. Traffic to Redis is always going to the master database and is not distributed over all three VM's. In case of a problem with the master database, HAproxy automatically switches to the new master assigned by Redis sentinel (see below).

## APP's
The APP's are the servers running the Ruby application. See also: https://github.com/antirez/lamernews. This application is cloned from it's own Git repository (so you are free to use another branch or repo if you want).

## DB's
The DB's are servers which run the Redis database (one master, the rest configured as slaves). These servers also have Redis sentinel running, so in case of an issue with one of the servers, there will be always one master present. HAproxy takes care of redirecting the traffic to the right database. Please be aware that there are always two (or more) DB's necessary for sentinel to work. This has to do with the quorum of 2, which is a bare minimum. So in this setup, there can only fail one DB.

# Features
* All components are loadbalanced and in pairs (or more), so you can kill/break one of the pair (e.g. kill app2, because we also have app1)
* Because Vagrant is used, the whole environment runs in Virtualbox on your own laptop. It is also possible to run the same environment on AWS, VMware and a lot more providers (if there is a box image present). You can test the environment this way on your laptop, and when everything is ready you can deploy that exact configuration on AWS for example. Vagrant takes care of this.
* The systems are being created by Vagrant and then provisioned by Saltstack. This way you can easily add or remove servers or change the config.
* Because Vagrant is used, you always have exactly the same enviroment on your laptop as there is in the datacenter for instance. So no more "works on my machine" excuses.
