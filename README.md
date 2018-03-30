#This is my vim setup
This repo includes a basic vim setup that should help you get started with vim. Feel free to use this, but make sure you understand what each command does (my comments and :h are your friends :) )

To use, clone this repo, copy the .vim to your home directory, then do one of the below steps.

### A.
Place .vimrc in your .vim folder
Place "runtime .vim/.vimrc" in your own ~/.vimrc
```
mv .vimrc .vim
cd ~
echo "runtime /path/to/.vim/.vimrc" >> .vimrc
```
(Note: I haven't tested this out yet)

### B.
make symlinks to both the .vim folder and the .vimrc file
```
ln -s ~/path/to/.vim ~/.vim
ln -s ~/path/to/.vimrc ~/.vimrc
```

## TODO
- [x] Add basic platform specific functionality
- [ ] Implement useful platform specific features
- [ ] Add a few plugins
- [ ] Test on Mac (add mac specific features)
