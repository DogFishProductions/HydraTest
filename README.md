# HydraTest
Learning Hydra for microservices.

## Create a service

```
$ yo fwsp-hydra 
```

## Creating a script to respond to a Yeoman Generator
Yeoman generators don't use the standard input so it's not possible to use a [Unix Here Document][unix-here] to respond to them. We have to use the Unix `expect` [utility][expect] instead to create an interactive script. Macos comes with `expect` built in (it's at `/usr/bin/expect`) but this doesn't come with the excellent `autoexpect` [utility][autoexpect] which creates `expect` files automatically. To get this we have to use [**Homebrew**][homebrew]:

```
$ brew tap homebrew/dupes
$ brew install expect
```

Using `expect` on the command line will now call the **Homebrew** version by default but the native version is still available at `/usr/bin/expect`. We can now use `autoexpect` to create an executable for creating services automatically in **Docker**. To do this, `cd` to the scripts directory.  Then:

```
$ autoexpect -f create-<service-name>-service.exp yo fwsp-hydra
```

Substitute `<service-name>` with the name of your service to be created. Follow the interactive prompts from the Yeoman generator. When complete, run your script using:

```
$ expect create-<service-name>-service.exp
```
## Running Hydra-Router
Get the network IP address of the redis container (this assumes the redis container is on the default bridge network):

```
$ docker network inspect docker_default
[
    {
        "Name": "docker_default",
        "Id": "72a15d0588e576afb556b03285ba1769ce7b27438b4477fddaf2bdbc6d0881a9",
        "Created": "2017-07-24T14:53:56.906224558Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": true,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "3e29254fe552e06ccd2c4fb4f58f7e2d978f4167822c003bd39ac651e66ebc7c": {
                "Name": "docker_redis_1",
                "EndpointID": "f54888a68d0f67d9d0f4558883e63ee17d6cc5bd5fd6ab100fd11fcd2b8d9b33",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            },
            "413e04e95a6fbd55f8a592ce1a72032fa3d6a69560437e5d2ec4ba2d3f9a9d72": {
                "Name": "docker_hydra_1",
                "EndpointID": "6b930245c8a0e0f418c2cf0fa398edf270ef85cabfe7bb7e89a2f4a0d3a3047a",
                "MacAddress": "02:42:ac:12:00:03",
                "IPv4Address": "172.18.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {
            "com.docker.compose.network": "default",
            "com.docker.compose.project": "docker"
        }
    }
]
```

Knowing the IP address we can connect to redis and start the hydra-router:

```
docker run -d -p 5353:5353 --add-host host:172.18.0.2 --network docker_default --name hydra-router flywheelsports/hydra-router:1.4.13
```

## References
 - [Hydra docs][hydra]
 - [Example docs][example]

 [hydra]: https://www.hydramicroservice.com/
 [example]: https://community.risingstack.com/building-a-microservices-example-game-with-distributed-messaging/
 [here-doc]: http://tldp.org/LDP/abs/html/here-docs.html
 [expect]: https://linux.die.net/man/1/expect
 [autoexpect]: http://expect.sourceforge.net/example/autoexpect.man.html
 [homebrew]: https://brew.sh/