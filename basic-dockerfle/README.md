

### I recommended to research how to install docker on your machine for this project

### I created this app using the python image (a bit different but this then means you can customise your python script how you want)

1. Create a python file, I named mine app.py & add all code you wish for it

2. Create a new file and call it **Dockerfile**. This specifies to run from python image, to copy this path and also execute the file (I have one in this repository)

3. In the current folder directory that containes app.py and the Dockerfile run this command. This creates your docker image.
   'hello-captain' can be any name you wish (-t is a flag that gives your image a name, the . is to build everything in that current path)
```bash
docker build -t hello-captain .
```
4. Now it has been built, you can run the container using and you should see the output of whatever is in your 'app.py' file
```bash
docker run hello-captain
```


project for docker file
https://roadmap.sh/projects/basic-dockerfile