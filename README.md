# Saldo-inflector

Saldo inflector is a morphological inflector for Swedish. It is built from the Haskell source code [released by Språkbanken](https://spraakbanken.gu.se/resurser/saldo). (Scroll to the bottom of the page and look in the archive labeled SALDO v.1.)

The morphological paradigms for saldo were carved out from the source code and adapted to build (hopefully reproducibly) using a modern Haskell stack. Glue code was written such that these paradigms can be used from Python:

```python
>>> from saldo import Saldo
>>> s = Saldo()
>>> s.inflect("nn_1u_ros", "ros", "pl indef gen")
['rosors']
>>> s.paradigm("nn_1u_ros", "ros")
{'sg indef nom': ['ros'], 'sg indef gen': ['ros'], 'sg def nom': ['rosen'], 'sg def gen': ['rosens'], 'pl indef nom': ['rosor'], 'pl indef gen': ['rosors'], 'pl def nom': ['rosorna'], 'pl def gen': ['rosornas'], 'comp': ['ros-', 'ros']}
```

This library supports amd64 and aarch64 Linux and macOS. There is no fundamental reason as to why it couldn't support Windows, the effort to build the `dll` has just not been expended as of yet.

## Installation

### Pypi

Simply `pip install saldo-inflector`.

### Building for Linux

Prerequisite: a working Docker environment and `make`. Do

```shell
make docker-python-linux-amd64
```

or

```shell
make docker-python-linux-aarch64
```

depending on which architecture you wish to build for. The resultant `.whl` should pop into `saldo-python/dist`. It can be installed eg. with pip like any other `.whl`:

```shell
pip install path/to/the.whl
```

NB: The docker command copies the files from the subdirectories and the Makefile over to the container. If you are building both inside and outside of the docker image (both for Linux and macOS), you should probably do Linux first so as to not copy errant files created by the non-containerized build over.

### Building for macOS

Prerequisite: `make`, [`stack`](https://docs.haskellstack.org/en/stable/) and `python3` environment (venv should be the easiest) with recent versions of `build` and `wheel`.

Do `make`. Cross-building between different macOS architectures isn't supported as of now.

## Usage

Create a `saldo.Saldo()` and use its only method, `inflect`. It takes the paradigm, lemma and inflection as parameters in that order. It returns a list of strings is the paradigm and inflection were understood and None otherwise.

## Paradigms

TBD

## Inflection descriptions

TBD

## License

The original saldo is dual-licensed under CC-BY and LGPL v.3. As a result, `saldo-inflector` is under the LGPL v.3 license, copyright 2023 Kielikone oy.
