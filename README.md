# webapp blueprint

kubemate web application blueprint based on the app blueprint.

## Usage
Create a new application by fetching, configuring and rendering this [kpt](https://kpt.dev/) package.

### Fetch the package
To create a new application `myapp` using this package as a blueprint, run:
```sh
kpt pkg get https://github.com/mgoltzsche/kubemate-app-blueprints.git/packages/webapp[@VERSION] myapp
```

or with `docker`:
```sh
docker run --rm -u `id -u` -e HOME=/tmp -v `pwd`:/data -w /data gcr.io/kpt-dev/kpt:v1.0.0-beta.25 pkg get https://github.com/mgoltzsche/kubemate-app-blueprints.git/packages/webapp myapp
```

See [`kpt pkg get` documentation](https://kpt.dev/reference/cli/pkg/get/).

### Customize the package
Within the fetched package's directory, edit [`setters.yaml`](./setters.yaml) to meet your requirements.
To replace the corresponding values within the manifests and skaffold.yaml, call `make render` or rather [`kpt fn render`](https://kpt.dev/reference/cli/fn/render/).

TL;DR: [Variant Constructor Pattern](https://kpt.dev/guides/variant-constructor-pattern)

## Development

To list the supported targets, run `make help`.

### Prerequisites

* git
* make
* [docker 20+](https://docs.docker.com/engine/install/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

### Build the application
To build the application container image using [skaffold](https://skaffold.dev), run:
```sh
make image
```

### Deploy the application
To deploy the application using [skaffold](https://skaffold.dev), run:
```sh
make deploy
```
To deploy the application in debug mode (debug ports forwarded), stream its logs and redeploy on source code changes automatically, run:
```sh
make debug
```

To undeploy the application, run:
```sh
make undeploy
```

### Apply blueprint updates
To apply blueprint updates to the application codebase, update the [kpt](https://kpt.dev/) package:
1. Before updating the package, make sure you don't have uncommitted changes in order to be able to distinguish package update changes from others.
2. Call `make blueprint-update` or rather [`kpt pkg update`](https://kpt.dev/reference/cli/pkg/update/) and [`kpt fn render`](https://kpt.dev/reference/cli/fn/render/) (applies the configuration within [`setters.yaml`](./setters.yaml) to the manifests and `skaffold.yaml`).
3. Before committing the changes, review them carefully and make manual changes if necessary.

TL;DR: [Variant Constructor Pattern](https://kpt.dev/guides/variant-constructor-pattern)

## Release

The release process is driven by [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0-beta.4/), letting the CI pipeline generate a version and publish a release depending on the [commit messages](https://semantic-release.gitbook.io/semantic-release/#commit-message-format) on the `main` branch.
