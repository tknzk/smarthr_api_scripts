# smarthr_api_scripts


# install

```
git clone git@github.com:tknzk/smarthr_api_scripts.git
```


```
bundle install --path=vendor/bundle
```

# 設定

api-token を取得し、```.env``` に設定する

```.env
SMARTHR_SUBDOMAIN=サブドメイン
SMARTHR_API_TOKEN=API TOKEN を設定
```

# 実行

```
bundle exec smarthr-api-cli

Commands:
  smarthr-api-cli crew            # Crew samples
  smarthr-api-cli help [COMMAND]  # Describe available commands or one specific command
```

## crew
```
bundle exec smarthr-api-cli crew --help

Commands:
  smarthr-api-cli crew bulk update crew.emp_code from csv  # bulk_update_emp_code CSV_PATH
  smarthr-api-cli crew dump to csv                         # dump
  smarthr-api-cli crew help [COMMAND]                      # Describe subcommands or one specific subcommand

```

### dump csv

```
bundle exec smarthr-api-cli crew dump
```

- dump.csv というファイルが生成される


### bulk_update_emp_code

```
bundle exec smarthr-api-cli crew bulk_update_emp_code ./update.csv
```

- update.csv に書き換えたい emp_code を設定して一括変更する

