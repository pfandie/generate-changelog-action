# Generate changelog with git-chglog

This GitHub Action creates a CHANGELOG output based on git-chglog tool. \
For configuration options see the [git-chglog](https://github.com/git-chglog/git-chglog) repository.

## Features

- Generates the CHANGELOG changes in Markdown format based on git-chglog.
- Exports changelog to a variable that can used in a subsequent step to create a release changelog.
- Use your exiting git-chglog configuration and template.
- Create a new CHANGELOG.md file or append to an existing one.

## Example workflows

### Generate CHANGELOG on every `push` to `main`

```yaml
name: Build and release
on: 
  push:
    branches:
      - main

jobs:
  package:
    runs-on: ubuntu-latest
    steps:
      - uses: pfandie/generate-changelog-action@v1
        with:
          next_version: "${{ github.ref_name }}"
```

### Generate CHANGELOG on `push` to `release` branches

```yaml
name: Build and Release

on:
  push:
    branches:
      - 'release/*'

jobs:
  custom_test:
    runs-on: ubuntu-latest

    permissions:
      contents: write
      pull-requests: read

    name: Generate Release
    steps:
      - name: checkout
        uses: actions/checkout@v3

      - name: Generate Changelog
        uses: pfandie/generate-changelog-action@v1
        id: changelog
        with:
          config_path:
          next_tag: "${{ github.ref_name }}"
          output_file: "MyChangelog.md"
          write_file: true
```

### Generate CHANGELOG and Release on tag push

```yaml
name: Build and Release

on:
  push:
    tags:
      - 'v*'

jobs:
  custom_test:
    runs-on: ubuntu-latest

    permissions:
      contents: write
      pull-requests: read

    name: Generate Release
    steps:
      - name: checkout
        uses: actions/checkout@v3

      - name: Generate Changelog
        uses: pfandie/generate-changelog-action@v1
        id: changelog

      - name: Create Release
        uses: ncipollo/release-action@v1.12.0
        with:
          makeLatest: true
          token: ${{ github.token }}
          body: ${{ steps.changelog.outputs.changelog }}
          name: "Release ${{ github.ref_name }}"
```

## Input Parameters

| Parameter     | Description                                                      | Required           | Default        |
|---------------|------------------------------------------------------------------|--------------------|----------------|
| `config_path` | Path to config directory. Defaults to: `.chglog`                 | :x:                | `null`         |
| `next_tag`    | The next tag for version number, e.g. `"${{ github.ref_name }}"` | :white_check_mark: | `null`         |
| `output_file` | Name of the output file, requires `write_file` == true           | :x:                | `CHANGELOG.md` |
| `write_file`  | Write output to file                                             | :x:                | `false`        |

### Outputs
- `changelog`: Changelog content if `outputFile` is not set

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/pfandie/generate-changelog-action/tags).

## License
The scripts and documentation in this project are released under the [MIT License](LICENSE)

## Credits

- [github-changelog-action](https://github.com/nuuday/github-changelog-action) for inspiring to extend the actions
- [git-chglog](https://github.com/git-chglog/git-chglog) for a great tool on creating (and customizing) CHANGELOG
- [jacobtomlinson](https://github.com/jacobtomlinson) for the post of [Creating GitHub Actions in Go](https://jacobtomlinson.dev/posts/2019/creating-github-actions-in-go/)
