# Automated configuration

Some scripts to ease the pain of migrating to a new machine.

## Installation

1. Clone .config_scripts into your filesystem.

	git clone https://github.com/dkudrow/.config_scripts.git

2. Clone the submodules.

	git submodule init
	git submodule update

3. Move the directory to a location where it can remain unmoved. Changing
   the location will break symbolic links.

	mv .config_scripts /path/to/final/resting/place

4. Change to the top-level directory in the repository.

	cd /path/to/.config_scripts

5. Run the setup script.

	./setup.sh

## Adding vim-pathogen plugins
To add a plugin, simply add it as a git submodule:

	git submodule add repository local_path

When cloning .config_scripts on a fresh machine, run:

	git submodule init
	git submodule update
