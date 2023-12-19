Things to do still:

* Make selectors run a certain model/method instead of only ttn.measurement->create.
* Selectors need to have a username attached to them, so that we call env["model"].with_user(self.user).{self.method}, otherwise
    untrusted webhook callers are running methods as root.