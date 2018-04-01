# Blockchain_Concepts

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
export $CHANNEL_NAME="mychannel"
export $ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

## 암호 생성 : crypto-config

이 작업을 수행하면 키가 배포된다.
`cryptogen generate --config=./crypto-config.yaml`

이 결과로 생성된 `crypto-config`를 각 Orderer, Peer에 분배한다.

## 채널 정보 생성 : configtx

* 채널 Genensis Block 생성 (genesis.block)

오더러는 이 파일을 orderer.genesis.block으로 만들어야 한다.

`configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block`

* 채널 설정 트랜잭션 (channel.tx)

`configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME`

* 각 Anchor Peer 설정

`configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP`

`configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP`

## Docker-compose에 따른 오더러, 피어, CA 설정

```bash
export FABRIC_CFG_PATH=/var/hyperledger/config
```

### Orderer

`orderer`

* 파일

```yaml
- ../channel-artifacts/genesis.block:/var/hyperledger/orderer/orderer.genesis.block
- ../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp:/var/hyperledger/orderer/msp
- ../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/:/var/hyperledger/orderer/tls
- orderer.example.com:/var/hyperledger/production/orderer
```

* 환경 변수

```yaml
      - ORDERER_GENERAL_LOGLEVEL=INFO
      - ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
      - ORDERER_GENERAL_GENESISMETHOD=file
      - ORDERER_GENERAL_GENESISFILE=/var/hyperledger/orderer/orderer.genesis.block
      - ORDERER_GENERAL_LOCALMSPID=OrdererMSP
      - ORDERER_GENERAL_LOCALMSPDIR=/var/hyperledger/orderer/msp
      # enabled TLS
      - ORDERER_GENERAL_TLS_ENABLED=true
      - ORDERER_GENERAL_TLS_PRIVATEKEY=/var/hyperledger/orderer/tls/server.key
      - ORDERER_GENERAL_TLS_CERTIFICATE=/var/hyperledger/orderer/tls/server.crt
      - ORDERER_GENERAL_TLS_ROOTCAS=[/var/hyperledger/orderer/tls/ca.crt]
```

### Peer

`peer node start`

* 파일

```yaml
- /var/run/:/host/var/run/
- ../crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp:/etc/hyperledger/fabric/msp
- ../crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls:/etc/hyperledger/fabric/tls
- peer0.org1.example.com:/var/hyperledger/production
```

* 환경 변수

```yaml
- CORE_PEER_ID=peer0.org1.example.com
- CORE_PEER_ADDRESS=peer0.org1.example.com:7051
- CORE_PEER_GOSSIP_BOOTSTRAP=peer1.org1.example.com:7051
- CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org1.example.com:7051
- CORE_PEER_LOCALMSPID=Org1MSP

- CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
- CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=${COMPOSE_PROJECT_NAME}_byfn
- CORE_LOGGING_LEVEL=INFO
#- CORE_LOGGING_LEVEL=DEBUG
- CORE_PEER_TLS_ENABLED=true
- CORE_PEER_GOSSIP_USELEADERELECTION=true
- CORE_PEER_GOSSIP_ORGLEADER=false
- CORE_PEER_PROFILE_ENABLED=true
- CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/fabric/tls/server.crt
- CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/fabric/tls/server.key
- CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/tls/ca.crt
```

## 네트워크 시작 시

### 채널 만들기

`peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx >&log.txt`

TLS 있을 시

`peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA >&log.txt`

### 채널 가입하기

`peer channel join -b $CHANNEL_NAME.block  >&log.txt`

### 앵커 피어 업데이트

`peer channel update -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx >&log.txt`

TLS 있을 시

`peer channel update -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA >&log.txt`

### 체인코드 설치

LANGUAGE=golang
VERSION=${3:-1.0}

`peer chaincode install -n mycc -v ${VERSION} -l ${LANGUAGE} -p ${CC_SRC_PATH} >&log.txt`

### 체인코드 인스턴스화

`peer chaincode instantiate -o orderer.example.com:7050 -C $CHANNEL_NAME -n mycc -l ${LANGUAGE} -v ${VERSION} -c '{"Args":["init","a","100","b","200"]}' -P "OR ('Org1MSP.peer','Org2MSP.peer')" >&log.txt`

TLS 있을 시

`peer chaincode instantiate -o orderer.example.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n mycc -l ${LANGUAGE} -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OR  ('Org1MSP.peer','Org2MSP.peer')" >&log.txt`

### 체인코드 질의

`peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}' >&log.txt`