HERE=$PWD
DESTINATION=/dev/shm
BACKUP=~/nothing.tar.gz
#DEV=/dev/urandom
DEV=/dev/video0

DEVICE="tv:// -tv driver=v4l2:width=1280:height=1024:device="
DEVICE+=$DEV

cd $DESTINATION

if [ $# -eq 0 ]; then
        echo "Usage: webcam [-c][-u][-r][-h][-b][-p][-s] "
        echo "      (c)opy / s(u)do / (r)ecord / (h)elp / (b)ackup / (p)lay / (s)ound"
    
else
	MODE=$1
	FILENAME=$2

	# Gain access to the webcam $DEV
    if [ $MODE == "-u" ]; then     
        sudo chown paul $DEV 
	    MODE=$2
		FILENAME=$3
    fi                                 

	# Record or Play a specific file

	# Copy the files to a location
    if [ $MODE = "-c" ]; then
        if [ -d $FILENAME ]; then
            if [ -e ./*.avi ]; then
                rsync -t -v -W  ./*.avi $FILENAME
			else
		        echo "No files to copy"
			fi
        else
            echo "Invalid directory destination"
        fi                                          
    fi

	# Backup the files
    if [ $MODE = "-b" ]; then
        if [ -e $DESTINATION ]; then
            tar xvfz $BACKUP    
        fi                      
        if [ -d nothing ]; then
            mkdir nothing  
        fi                   

        rsync -t -v -W  ./*.avi nothing
        tar -pczf $DESTINATION nothing/
    fi                                       
	
	# Play - runs mplayer with the webcam output
    if [ $MODE == "-p" ]; then
        if [ $# -eq 1 ]; then
            mplayer $DEVICE
        else
		    cd $HERE
		    mplayer `echo $FILENAME`
        fi                 
	fi

    if [ $MODE == "-r" ]; then
        if [ $# -eq 1 ]; then
            VAR=cam_`date +%F_%H:%M`.avi
        else
            cd $HERE
			VAR=$FILENAME  
        fi
		echo $VAR, $DEVICE 
		echo mencoder $DEVICE -ovc lavc -o $VAR
		mencoder $DEVICE -nosound -ovc lavc -o $VAR
		#mencoder tv:// -tv driver=v4l2:width=352:height=288:device=/dev/video0 -ovc lavc -o test.avi
		#mencoder tv:// -tv driver=v4l2:width=352:height=288:device=/dev/video0 -nosound -ovc lavc -o test.avi
        #mencoder tv:// -tv driver=v4l2:width=352:height=288:forceaudio:alsa:device=/dev/video0 -oac lavc -ovc lavc -o test.avi
	fi
	if [ $MODE == "-s" ]; then
        if [ $# -eq 1 ]; then
            VAR=cam_`date +%F_%H:%M`.avi
        else
            cd $HERE
			VAR=$FILENAME  
        fi
	echo $VAR, $DEVICE 
        time mencoder tv:// -tv driver=v4l2:width=352:height=288:forceaudio:alsa:device=/dev/video0 -oac lavc -ovc lavc -noskip -o $VAR	
	fi
fi


cd $HERE
