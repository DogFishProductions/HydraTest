# HydraTest
Learning Hydra for microservices.

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

Substitute `<service-name>` with the name of your service to be created. Follow the interactive prompts from the Yeoman generator. When complete, run:

```
$ chmod +x create-<service-name>-service.exp
```

Your `expect` file is now executable and can be run by simply calling it.

## References
 - [Hydra docs][hydra]
 - [Example docs][example]

 [hydra]: https://www.hydramicroservice.com/
 [example]: https://community.risingstack.com/building-a-microservices-example-game-with-distributed-messaging/
 [here-doc]: http://tldp.org/LDP/abs/html/here-docs.html
 [expect]: https://linux.die.net/man/1/expect
 [autoexpect]: http://expect.sourceforge.net/example/autoexpect.man.html
 [homebrew]: https://brew.sh/