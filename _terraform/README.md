# terraform

Resources managed by [terraform](https://www.terraform.io/). Since the HCL format is very agitating, especially around templating out resources like DNS records, I've Rube-Goldberged up and rely on [jinja2](https://jinja.palletsprojects.com) to perform templating on each file in `templates/`.

# security

I'm basically publishing zone files for my DNS here... fortunately I don't have any very juicy bits of info here, but even still: probably not the best security practice in the world.

# templating

Every file in the `templates/` directory is templated out by jinja and then output a file with the same name in `workspace/`.

All `*.toml` files in `variables/` are processed in to a single namespace which is available to the template files. The file name without the extension of the `*.toml` file is made a key available to the templates, and all inner values available based on their key/value in the file.

## example

given a file `variables/file.toml` containing

```toml
[values]
x = 10
y = 20
```

Any template file can refer to `file.values.x` to get the value `10`
