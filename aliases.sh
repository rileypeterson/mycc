#!/bin/bash

alias remake='(
mv ~/Documents/my_project/config/.dev.env /tmp &&
mv ~/Documents/my_project/config/.prod.env /tmp &&
rm -rf ~/Documents/my_project &&
cd ~/Documents/ &&
yes | cookiecutter --replay ~/Documents/mycc &&
mv /tmp/.dev.env ~/Documents/my_project/config/.dev.env &&
mv /tmp/.prod.env ~/Documents/my_project/config/.prod.env &&
cd ~/Documents/mycc
)'