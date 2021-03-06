# Automated configuration
Some scripts to ease the pain of migrating to a new machine.

## Installation
1. Clone `.dotfiles` into your filesystem.

		git clone https://github.com/dkudrow/.dotfiles.git

2. Clone the submodules.

		git submodule init
		git submodule update

3. Move the directory to a location where it can remain unmoved. Changing the location will break symbolic links.

		mv .dotfiles /path/to/final/resting/place

4. Change to the top-level directory in the repository.

		cd /path/to/final/resting/place/.dotfiles

5. Run the setup script (use `-h` to see options).

		./setup.sh
	
## Adding configurations
Adding a set of configuration files is pretty simple:

1. Create a directory in `.dotfiles` and `cd` into it.

		cd /path/to/.dotfiles
		mkdir my_new_config

2. Create a copy of the directory tree containing the config files.

		cp ~/.my_rc .
		mkdir -p nested/config/
		cp ~/nested/config/file.conf nested/config/
	
3. Create a `setup.sh` file. This file tells the config script which files to install an where. All it does is define a few variables for the top-level script to use.

		> setup.sh
	
4. `REPO_DIR` is the directory in `.dotfiles` where the new config files will live.

		echo "REPO_DIR=my_new_config" >> setup.sh

5. `CONFIG_DIR` is the directory to which the the config files will be installed.

		echo "CONFIG_DIR=~" >> setup.sh

6. `CONFIG_FILES` is a list of files to be installed. Filenames ending in `/` are assumed to be directories and all of their contents will be installed.

		echo "CONFIG_FILES=(.my_rc nested/config/file.conf)" >> setup.sh

7. `LOCAL_FILES` is a list of files that will be created if they don't exist but are otherwise unaltered. This allows you to keep local configurations per machine without interfering with the repo.

		echo "LOCAL_FILES=.my_rc.local" >> setup.sh
	
8. And that's it! Running the top level `setup.sh` will now install your new config!

## Adding vim-pathogen plugins
To add a plugin, simply add it as a git submodule:

		cd /path/to/.dotfiles
		git submodule add https://github.com/scrooloose/nerdtree.git vim/.vim/bundle/nerdtree

When cloning `.dotfiles` on a fresh machine, run:

		git submodule init
		git submodule update
