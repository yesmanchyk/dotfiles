# docker build -t clangd-modules .
FROM silkeh/clang:20
RUN apt update
RUN apt install -y unzip git libssl-dev curl screen
RUN wget https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz
RUN tar xaf nvim-linux-x86_64.tar.gz
RUN wget https://github.com/clangd/clangd/releases/download/20.1.0/clangd-linux-20.1.0.zip
RUN unzip clangd-linux-20.1.0.zip
RUN rm -fr CMake
RUN git clone https://github.com/Kitware/CMake.git
RUN cd CMake && git checkout v4.0.1 && ./bootstrap && make && make install && cd ..
RUN git clone https://github.com/ninja-build/ninja.git
RUN cd ninja && ./configure.py --bootstrap && cp ninja /usr/bin && cd ..
RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN git clone https://github.com/yesmanchyk/dotfiles.git
RUN mkdir -p ~/.config/nvim
# cp dotfiles/init.vim ~/.config/nvim/init.vim
# :PlugInstall inside nvim
# in case of failure run
# git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
# rm -fr ~/.config/nvim/pack
# rm -fr ~/.local/share/nvim/plugged/*
# Try example from https://www.kitware.com/import-cmake-the-experiment-is-over/ #
# root@74a83a92ad25:/src/import-cmake-the-experiment-is-over# cat build.sh
# rm -fr build compile_commands.json
# mkdir build
# cd build
# CXX=clang++ CC=clang cmake -GNinja ..
# CXX=clang++ CC=clang cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
# ninja -v
# cd ..
# ln -s `find build -name compile_commands.json` compile_commands.json
# build/hello

# root@74a83a92ad25:/src/import-cmake-the-experiment-is-over# ls -la
# total 32
# drwxr-xr-x 4 root root 4096 Apr 27 14:57 .
# drwxr-xr-x 3 root root 4096 Apr 27 13:47 ..
# drwxr-x--- 3 root root 4096 Apr 27 14:35 .cache
# -rw-r--r-- 1 root root  544 Apr 27 14:28 CMakeLists.txt
# drwxr-xr-x 3 root root 4096 Apr 27 14:57 build
# -rw-r--r-- 1 root root  268 Apr 27 14:54 build.sh
# lrwxrwxrwx 1 root root   27 Apr 27 14:57 compile_commands.json -> build/compile_commands.json
# -rw-r--r-- 1 root root  436 Apr 27 14:50 foo.cxx
# -rw-r--r-- 1 root root  162 Apr 27 14:56 main.cxx
