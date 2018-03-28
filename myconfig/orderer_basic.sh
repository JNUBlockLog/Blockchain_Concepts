MSP_NAME=$1

ORDERER_KEYPATH=/var/hyperledger/crypto-config/ordererOrganizations/logsystem.com/orderers/orderer.logsystem.com
CHANNEL_ARTIFACTPATH=/var/hyperledger/channel-artifacts

export FABRIC_CFG_PATH=/var/hyperledger/config
export FABRIC_MSP_PATH=$FABRIC_CFG_PATH/config/msp # crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/
export ORDERER_GENERAL_LOGLEVEL=INFO
export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_GENESISFILE=$CHANNEL_ARTIFACTPATH/orderer.genesis.block
export ORDERER_GENERAL_LOCALMSPID=$MSP_NAME
export ORDERER_GENERAL_LOCALMSPDIR=$ORDERER_KEYPATH/msp # msp
# enabled TLS
export ORDERER_GENERAL_TLS_ENABLED=true
export ORDERER_GENERAL_TLS_PRIVATEKEY=$ORDERER_KEYPATH/tls/server.key
export ORDERER_GENERAL_TLS_CERTIFICATE=$ORDERER_KEYPATH/tls/server.crt
export ORDERER_GENERAL_TLS_ROOTCAS=[$ORDERER_KEYPATH/tls/ca.crt]

export CORE_PEER_LOCALMSPID="OrdererMSP"
export CORE_PEER_TLS_ROOTCERT_FIL=crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export CORE_PEER_MSPCONFIGPATH=crypto/ordererOrganizations/example.com/users/Admin@example.com/msp


echo ORDERER_GENERAL_LOGLEVEL=INFO
echo ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
echo ORDERER_GENERAL_GENESISMETHOD=file
echo ORDERER_GENERAL_GENESISFILE=$CHANNEL_ARTIFACTPATH/orderer.genesis.block
echo ORDERER_GENERAL_LOCALMSPID=$MSP_NAME
echo ORDERER_GENERAL_LOCALMSPDIR=$ORDERER_KEYPATH/msp # msp

echo ORDERER_GENERAL_TLS_ENABLED=true
echo ORDERER_GENERAL_TLS_PRIVATEKEY=$ORDERER_KEYPATH/tls/server.key
echo ORDERER_GENERAL_TLS_CERTIFICATE=$ORDERER_KEYPATH/tls/server.crt
echo ORDERER_GENERAL_TLS_ROOTCAS=[$ORDERER_KEYPATH/tls/ca.crt]