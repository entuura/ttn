Things to do still:

* Make selectors run a certain model/method instead of only ttn.measurement->create.
* Selectors need to have a username attached to them, so that we call env["model"].with_user(self.user).{self.method}, otherwise
    untrusted webhook callers are running methods as root.
* find out if the GPS tracker is already available in TTN ui, and if so, fix it's model name

Try following this tutorial to learn how to make a time series graphwidget.
  https://www.oocademy.com/v15.0/tutorial/creating-javascript-classes-and-widgets-in-odoo-119
(and then a map using open street map)
