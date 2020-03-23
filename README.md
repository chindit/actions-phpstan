# actions-phpstan
PHPStan action for GitHub on PHP 7.4

## Setup
Add these lines to your YAML config file
```yaml
- name: PHPStan
  uses: chindit/actions-phpstan@master
```

**WARNING** : Be sure you have this line **before** :
```yaml
- uses: actions/checkout@v2
```

Your workflow file should look like this:
```yaml
name: phpstan
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: PHPStan
        uses: chindit/actions-phpstan@master
        with:
          # Arguments to add to PHPStan
          arguments: 'src/ --level=7'
```

**TIP**: You can replace `@master` by `@1.0.0` or any specific version of this
package you'd like to use.

### Autoloader
If your dependencies are not installed, you may get errors from PHPStan.
Just add these lines **before** calling `chindit/phpstan`:
```yaml
- name: Install dependencies
  run: composer install --prefer-dist --no-progress --no-suggest
```

### Arguments
By default, `phpstan` is ran with current directory in analyse mode.

CLI launched is `phpstan analyse .`

If you want to modify method, directory or add a config file, set analyse level or anything else,
you can do so by specifying `arguments`

For example
```yaml	
  with:	
    arguments: '. --level=7' 
```

**IMPORANT** If you forget `analyse` keyword, it will be automatically added,
but you **must** respect PHPStan's CLI order and you **must** specify working
directory if you want to use other arguments such as `--level`.

For example, `arguments: '--level=7'` won't work, but `arguments: '. --level=7'` will.
