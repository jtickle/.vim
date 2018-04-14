To install and bootstrap pathogen and its modules...
'''
cd ~
git clone git://github.com/jtickle/.vim.git
echo "runtime vimrc" > .vimrc
cd .vim
./update-all
'''

To Update Pathogen and all your bundles...
'''
cd .vim
./update-all
'''

To install a new bundle, add it to the HEREDOC at the top of update-all, and
then run update-all.
