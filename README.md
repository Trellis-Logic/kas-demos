# Kas demo scripts

Scripts used to demonstrate various kas builds

## Setup

```
pip3 install kas
```

## Usage

```
config=myconfig
mkdir build-${project}
cd build-${project}
kas build --update ../kas/${project}.yml
```

where `${project}` is a specific kas configuration to demo
from the list of .yml files in the [kas](kas) subdir
and outlined below

## Demo Projects

### swupdate-oe4t

A demo of the [Swupdate for NVIDIA Tegra](https://github.com/OE4T/tegra-demo-distro/tree/master/layers/meta-tegrademo/dynamic-layers/meta-swupdate)
layer from tegra-demo-distro.  See the README there for details.

### swupdate-rootfs-overlay-oe4t

A demo of the swupdate-oe4t project with the addition of a read only rootfs with overlay
and /data partition for non-volatile storage.
