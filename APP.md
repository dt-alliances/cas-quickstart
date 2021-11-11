# Start the sample application

Follow these steps to start the sample application and view it in a browser

## Step 1: Start up the sample application with Docker.

1. In the SSH terminal, change to the scripts directory and start up the application

    ```
    cd ~/cas-quickstart/scripts
    sudo ./start-app.sh
    ```

    You want to see two running containers. The output should look like:

    ```
    ***** Init Log ***
    START_TIME       : Mon Nov  8 17:41:34 EST 2021 
    ...
    ...
    **** Getting docker processes ***
    CONTAINER ID   IMAGE                          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
    a873ae0e8d4b   dtdemos/casdemoappload:1.0.0   "sh -c '/load.sh ${H…"   11 seconds ago   Up 10 seconds                                           scripts_sendload_1
    3c2188c8b726   dtdemos/casdemoapp:1.0.0       "docker-entrypoint.s…"   11 seconds ago   Up 10 seconds   0.0.0.0:80->8080/tcp, :::80->8080/tcp   scripts_demoapp_1

    START_TIME: Mon Nov  8 17:41:34 EST 2021     END_TIME: Mon Nov  8 17:41:58 EST 2021

    ```

## Step 2: View application in a browser

Using the public IP for the virtual machine, open the application with `http://[public-ip]`.  It should look like this:

<img src="images/app.png" width="50%" height="50%">

## Useful commands

The following commands are just reference

* View running containers: `sudo docker ps`
* View logs of sample app or the load app `sudo docker logs [CONTAINER ID]`  (Get [CONTAINER ID] from the `sudo docker ps` command)
* Follow logs of sample app `sudo docker logs [CONTAINER ID] -f`  (Use ctrl-c to exit)
* Stop the application `sudo ./stop-app.sh`

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](SETUP.md) [<img src="images/next.png" width="50px" height="50"/>](ONBOARD.md)