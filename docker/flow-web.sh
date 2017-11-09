# export FLOW_WEB_DIR=/Users/firim/workspace/flow-pf/flow-web/dist
#CMD bash $FLOW_WEB_DIR/flow-web.sh


export FLOW_WEB_DIR=/var/www/flow-web

sed -e "s#:FLOWCI:#${FLOW_API_DOMAIN}#g"  $FLOW_WEB_DIR/index.html > $FLOW_WEB_DIR/tmp.html

mv $FLOW_WEB_DIR/tmp.html $FLOW_WEB_DIR/index.html