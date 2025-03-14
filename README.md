# Kas demo scripts

Scripts used to demonstrate various kas builds

## Setup

```
pip3 install kas
```

## Usage

```
config=myconfig
mkdir build-${config}
cd build-${config}
kas build --update ../kas/${config}.yml
```

where config is a specific kas configuration to demo
from the list of .yml files in the [kas](kas) subdir
