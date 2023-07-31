# Non-root Ubuntu

With this image, you will log in as a non-root user. Since the user has already joined `sudoers`, you can use `sudo` to deal with a task requiring permission.

Docker images of Ubuntu are distributed officially, but the default user of them is root. It is not a problem in most cases. However, there are some cases in which we need a non-root user, like executing some software that cannot be run as root mainly for security reasons, or testing an application to check whether it violates permission rules or not. (If you run it as root, it would never fail because you are privileged.) So, an image in which you are going to log in as a non-root user can be helpful.
