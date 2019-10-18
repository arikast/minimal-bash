### The bare minimum I need for bash shell happiness

To use:

1. clone this repo
2. source the scripts in your $HOME/.bash_profile or $HOME/.bashrc:
`
echo '. /where/ever/you/cloned/minimal-bash/.bash_minimal' >> $HOME/.bash_profile
` 

Note that minimal-bash provides a nifty .../ autocompletion for the cd command, but the very popular bash-completion script provides its own custom completions for the cd command too.
so if you use both, you'll have to choose which completion behavior you want by sourcing the relevant script last in your $HOME/.bash_profile or $HOME/.bashrc

### quick guide to completion commands provided here

- `u` is equivalent to cd ..
- `u 3` is equivalent to cd ../../..
- `u mydir` is equivalent to cd ../../../mydir.  Note that you can also autocomplete mydir based on any dirs in your parent hierarchy
- `b` and `f` let you navigate back and forward through your history of PWD locations. unlike pushd/popd, it works with ordinary `cd` commands, and you can still move back again after going forward (unlike popd which loses the pushd history)
- `cd .../mydir` will autocomplete .../mydir into the first match from the following: ../mydir, ../../mydir, ../../../mydir, etc.  This also works for mv and cp commands. It saves you from having to figure out how many ../ prefixes to add when navigating/copying/moving one deeply nested directory to another likewise nested sibling directory.  This command currently requires ruby on your system to work.
