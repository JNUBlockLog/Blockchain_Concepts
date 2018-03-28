export CHANNEL_NAME=logsystem
export ORDERER_CA=$FABRIC_CFG_PATH/msp/tlscacerts/tlsca.logsystem.com-cert.pem

peer channel create -o orderer.logsystem.com:7050\
 -c $CHANNEL_NAME \
 -f ./channel-artifacts/channel.tx \
 --tls $CORE_PEER_TLS_ENABLED \
 --cafile $ORDERER_CA \
 >&log.txt