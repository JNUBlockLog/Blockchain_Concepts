MSP_NAME="OrdererMSP"

export FABRIC_CFG_PATH=/var/hyperledger/config
export FABRIC_ORDERER_PATH=/var/hyperledger/orderer # crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/
export ORDERER_GENERAL_LOGLEVEL=INFO
export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_GENESISFILE=$FABRIC_ORDERER_PATH/orderer.genesis.block
export ORDERER_GENERAL_LOCALMSPID=$MSP_NAME
export ORDERER_GENERAL_LOCALMSPDIR=$FABRIC_ORDERER_PATH/msp # msp
# enabled TLS
export ORDERER_GENERAL_TLS_ENABLED=true
export ORDERER_GENERAL_TLS_PRIVATEKEY=$FABRIC_ORDERER_PATH/tls/server.key
export ORDERER_GENERAL_TLS_CERTIFICATE=$FABRIC_ORDERER_PATH/tls/server.crt
export ORDERER_GENERAL_TLS_ROOTCAS=[$FABRIC_ORDERER_PATH/tls/ca.crt]

export CORE_PEER_LOCALMSPID=$MSP_NAME
export CORE_PEER_TLS_ROOTCERT_FIL=$FABRIC_ORDERER_PATH/msp/tlscacerts/tlsca.logsystem.com-cert.pem
export CORE_PEER_MSPCONFIGPATH=$FABRIC_ORDERER_PATH/users/Admin@example.com/msp


echo FABRIC_CFG_PATH=/var/hyperledger/config
echo FABRIC_ORDERER_PATH=var/hyperledger/orderer # crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/
echo ORDERER_GENERAL_LOGLEVEL=INFO
echo ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
echo ORDERER_GENERAL_GENESISMETHOD=file
echo ORDERER_GENERAL_GENESISFILE=$FABRIC_ORDERER_PATH/orderer.genesis.block
echo ORDERER_GENERAL_LOCALMSPID=$MSP_NAME
echo ORDERER_GENERAL_LOCALMSPDIR=$FABRIC_ORDERER_PATH/msp # msp
# enabled TLS
echo ORDERER_GENERAL_TLS_ENABLED=true
echo ORDERER_GENERAL_TLS_PRIVATEKEY=$FABRIC_ORDERER_PATH/tls/server.key
echo ORDERER_GENERAL_TLS_CERTIFICATE=$FABRIC_ORDERER_PATH/tls/server.crt
echo ORDERER_GENERAL_TLS_ROOTCAS=[$FABRIC_ORDERER_PATH/tls/ca.crt]

echo CORE_PEER_LOCALMSPID=$MSP_NAME
echo CORE_PEER_TLS_ROOTCERT_FIL=$FABRIC_ORDERER_PATH/msp/tlscacerts/tlsca.logsystem.com-cert.pem
echo CORE_PEER_MSPCONFIGPATH=$FABRIC_ORDERER_PATH/users/Admin@example.com/msp
