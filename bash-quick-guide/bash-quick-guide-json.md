# Работа с `JSON`
Тестовый файл `test.json` для демонстрации примеров:
```json
{
    "version": {
        "major": "0",
        "minor": "0",
        "patch": "1"
    },
    "uuid": null
}
```

## `jq`
Изменение в файле значения ключа patch. 
```sh
temp_file=$(mktemp)
jq --indent 4 '.version.patch = "27"' test.json > "${temp_file}" \
    && mv "${temp_file}" test.json
```
Тоже самое, но изменяемое значение является переменной, а не константой.
```sh
temp_file=$(mktemp)
jq --indent 4 --arg uid "$(uuidgen)" '.uuid = $uid' test.json > "${temp_file}" \
    && mv "${temp_file}" test.json
```

## `jo`
```sh

```
