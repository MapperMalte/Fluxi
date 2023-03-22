#!/bin/bash
pg_ctl -D /usr/local/var/postgres start
yes | mix phx.new fluxi_phoenix
cd fluxi_phoenix
mix ecto.create
cd ..
touch fluxiconf.fluxi
echo "phoenix_project_location: $(pwd)" >> fluxiconf.fluxi
git init
git add .
git commit -m "Hello from fluxi"
echo "$(tput setaf 2)Fluxi intialized phoenix-project for fluxi!$(tput sgr0)"
