#!/bin/bash
#########################################################################
# eeel - Edit-Eval-Execute Loop - "REPL" for C[++] etc.                 #
# Copyright (C) 2014  Aleksander Nitecki                                #
#                                                                       #
# This program is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation, either version 3 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program.  If not, see <http://www.gnu.org/licenses/>. #
#########################################################################

usage() {
	echo >&2 <<"EOF"
eeel - Edit-Eval-Execute Loop.
	You can think of it as "REPL" for C[++].
Usage: $0 [<filename>]
EOF
}

BLUE=$'\e[34m'
BOLD=$'\e[1m'
UNDERLINE=$'\e[4m'
RESET=$'\e[0m'

### main
filename=$1

#TODO instantiating [temporary] file from skeleton, provide skeletons for C[++].

while true
do
	"$EDITOR" "$filename"
	compile_command=`ack -m 1 --output='$1' 'ECRL: (.*)$' "$filename"` #TODO ack -> coreutils?
	eval $compile_command

	echo ${BOLD}${BLUE}_______________________________________________
	echo -n ${UNDERLINE}=== ${RESET}${UNDERLINE}${BOLD}'Press return to continue, C-d to exit loop.'${RESET}' '
	read || break
done

#read "Keep temporary file ${filename}?" #TODO
