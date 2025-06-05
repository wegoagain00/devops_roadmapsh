project for docker file

https://roadmap.sh/projects/basic-dockerfile

Recommended to search how to install docker on your machine

I created this app using the python image (a bit different but this then means you can customise your python script how you want)

1. create a python file i named mine app.py & add all code you wish for it

2. create a Dockerfile and this specifies to run from python image, to copy this path and also execute the file

3. in the current folder direcotry that containes app.py, Dockerfile run this command. this creates your docker image.
   'hello-captain' can be any name you wish

docker build -t hello-captain .

4. now it has been built, you can run the container using and you should see the output of whatever is in your 'app.py' file

docker run hello-captain
