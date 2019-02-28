# RedirectCodeGenerator

[![Build Status](https://travis-ci.org/tsmsogn/redirect_code_generator.svg?branch=master)](https://travis-ci.org/tsmsogn/redirect_code_generator)
[![codecov](https://codecov.io/gh/tsmsogn/redirect_code_generator/branch/master/graph/badge.svg)](https://codecov.io/gh/tsmsogn/redirect_code_generator)
[![Maintainability](https://api.codeclimate.com/v1/badges/5ee8d516b7ed906304bf/maintainability)](https://codeclimate.com/github/tsmsogn/redirect_code_generator/maintainability)

RedirectCodeGenerator creates Apache redirect code.

## Usage

```
$ ./create_apache_redirect_code /old_dir /new_dir
# 301 /old_dir -> /new_dir
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^/?old_dir$ /new_dir? [R=301,L]
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

