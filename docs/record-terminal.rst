Record a Terminal session
===========================

Script to record::

    #!/bin/bash

    export D=$HOME/scripts

    if [ -d $D ]; then
    	if [ $1 ]; then
    		if [ -f $D/commands$1 ]; then
    			echo "Error Occurred: file $1 already exists"
    			LAST=`ls -1 $D/commands* | sort | tail -n 1 | sed s:^$D/commands::`
    			echo "Last file: $LAST"
    		else
    			exec script -t$D/timing$1 $D/commands$1
    		fi
    	else
    		echo "Error occurred: no arg"
    	fi
    else
    	echo "Error occurred: dir $D does not exist"
    fi

Script to replay::

    #!/bin/bash

    export D=$HOME/scripts

    if [ -f $D/commands$1 ]; then
    	scriptreplay -t$D/timing$1 $D/commands$1 $2
    else
    	echo "Invalid filename"
    fi
