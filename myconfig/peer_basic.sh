PEER_NUM=$1
ORG_NAME=$2
MSP_NAME=$3
export FABRIC_CFG_PATH=/var/hyperledger/config
export CORE_PEER_ID=peer$PEER_NUM.$ORG_NAME.logsystem.com
export CORE_PEER_ADDRESS=peer$PEER_NUM.$ORG_NAME.logsystem.com:7051
export CORE_PEER_GOSSIP_BOOTSTRAP=peer$PEER_NUM.$ORG_NAME.logsystem.com:7051
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer$PEER_NUM.$ORG_NAME.logsystem.com:7051
export CORE_PEER_LOCALMSPID=$MSP_NAME

# /crypto-config/peerOrganization/`org1.example.com`/peers/`peer0`.org1.example.com/msp
# /crypto-config/peerOrganization/`org1.example.com`/peers/`peer0`.org1.example.com/tls
echo CORE_PEER_ID=peer$PEER_NUM.$ORG_NAME.logsystem.com
echo CORE_PEER_ADDRESS=peer$PEER_NUM.$ORG_NAME.logsystem.com:7051
echo CORE_PEER_GOSSIP_BOOTSTRAP=peer$PEER_NUM.$ORG_NAME.logsystem.com:7051
echo CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer$PEER_NUM.$ORG_NAME.logsystem.com:7051
echo CORE_PEER_LOCALMSPID=$MSP_NAME

export CORE_PEER_TLS_ROOTCERT_FILE=fabric/peer/crypto/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=fabric/peer/crypto/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
		