# ⛴ django boilerplate with nginx, gunicorn and certbot
A boilerplate app with nginx, gunicorn and certbot(Let's encrypt).

## Requirements
* `python3-dev`, `python3-pip`
* `docker`
* `docker-compose`
* `macOS` : without `certbot`
* `linux` : 🤖`certbot` is available.
* **"NO WINDOWS OS" 👋**

## 🕹Getting Started
To test the boilerplate, type just one command with one flag.
```
$ ./start.sh -t
``` 
or 
```
$ ./start.sh --test
```


To get up and running, simply do the following...
```
$ ./start.sh
Please input your django project name.
<your-project-name>
```
```
$ ./start.sh
Do you wish to use the certbot for https? [y/n]
```
> Just type `./start.sh` to start.

```
Do you wish to use the certbot for https? [y/n]
n
```
> If you want to test this app, type `n`. You can access boilerplate app "localhost".


```
Do you wish to use the certbot for https? [y/n]
y
```
> If you want to deploy the project on aws EC2, type `y`. Before activating certbot, you should set domain, static ip to deploy.