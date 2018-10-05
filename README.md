# grafana-beacon
Full grafana client and service to monitor some resources

just type:

```
  gem install gbeacon

  gbeacon.rb --help
```

## Linux

Install docker && Docker Compose:
```bash
sudo apt remove docker docker-engine docker.io
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker exampleuser
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Docker:
```
docker volume create --name=grafana-volume
sudo docker-compose up -d
```

## Login

`admin:admin`

## Add DB

Name: Graphite - Or other
Type: Graphite

### HTTP

URL: http://graphite:8080
Access: Server (default)

### Auth

BasicAuth: False
With Credentials: False
TLS Client Auth: False
With CA Cert: False

Skip TLS Verification (Insecure): False

### Advanced HTTP Settings

None

### Graphite Details

Select the newest available
