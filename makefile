build:
	docker build -t myjenkins jenkins-master/.
	docker build -t myjenkinsnginx jenkins-nginx/.

run:
	docker run -p 80:80 --name jenkins-nginx --network jenkins-net -d myjenkinsnginx
	docker run -p 50000:50000 --name jenkins-master --network jenkins-net --mount source=jenkins-log,target=/var/log/jenkins.log --mount source=jenkins-data,target=/var/jenkins_home -d myjenkins

stop:
	docker stop jenkins-master
	docker stop jenkins-nginx

rm:
	docker rm jenkins-master
	docker rm jenkins-nginx

network:
	docker network create --driver bridge jenkins-net

volumes:
	docker volume create jenkins-log
	docker volume create jenkins-data
