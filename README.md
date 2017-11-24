# RedirectCodeGenerator

RedirectCodeGenerator creates Apache redirect code

## Usage

```
$ ./create_apache_redirect_code /old_dir /new_dir
# 301 /old_dir -> /new_dir
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/old_dir$ /new_dir? [R=301,L]
</IfModule>
```

## Options

```
$ ./create_apache_redirect_code -h
Usage: create_apache_redirect_code [options]
        --[no-]permanent             Use permanent redirect (default: permanent)
        --[no-]escape                Escape any characters (default: escape)
    -v, --version                    Print version
```

## Todo

- Nginx

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tsmsogn/redirect_code_generator.

