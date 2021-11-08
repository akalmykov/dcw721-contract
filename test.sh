#!/bin/bash
./terrad tx wasm store artifacts/cw721terra.wasm --from test1 --chain-id=localterra --gas=auto --fees=100000uluna --broadcast-mode=block
./terrad tx wasm instantiate 7 '{"name":"dnft7", "symbol":"SMB", "minter":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"}' --from test1 --chain-id=localterra --fees=10000uluna --gas=auto --broadcast-mode=block

# 7: terra15nr8gcygpn9pq8urkzcf6hvzzvf0s2qt95hmjw

# mint original nfts - owner test2, minter test1

#https://opensea.io/assets/0x495f947276749ce646f68ac8c248420045cb7b5e/32024393116558880167652053681422857258225761992074790769429450187489077624835
./terrad tx wasm execute terra15nr8gcygpn9pq8urkzcf6hvzzvf0s2qt95hmjw \
'{"mint":{"token_id":"becca_notices", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmYvKtfCLZaNbM9D1f2TsCPSaaDYNu6dB6f8M5gcVCu7uU" } }}' \
\--from test1 --chain-id=localterra --fees=1000000uluna --gas=auto --broadcast-mode=block

#https://opensea.io/assets/0xc2c747e0f7004f9e8817db2ca4997657a7746928/5812
./terrad tx wasm execute terra15nr8gcygpn9pq8urkzcf6hvzzvf0s2qt95hmjw \
'{"mint":{"token_id":"vitalik_nakamoto", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/Qmf1FKrkPeipuhMdw8LUCXcwgd2QibB9vUmyJsaZXPkBeD" } }}' \
\--from test1 --chain-id=localterra --fees=1000000uluna --gas=auto --broadcast-mode=block

# mint derived nfts - owner test2, minter test2
./terrad tx wasm execute terra15nr8gcygpn9pq8urkzcf6hvzzvf0s2qt95hmjw \
'{"mint":{"token_id":"becca_nakamoto", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmYgmfJn1koj2bp2f2ZPHpc44d2b4tqZL7MVPajBnWkxYD", "derivative": {"method": "styletransfer", "source_ids" : ["becca_notices", "vitalik_nakamoto"] } } }}' \
\--from test2 --chain-id=localterra --fees=1000000uluna --gas=auto --broadcast-mode=block

# see minted derivative tokens
./terrad query wasm contract-store terra15nr8gcygpn9pq8urkzcf6hvzzvf0s2qt95hmjw '{"tokens":{"owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp"}}'
./terrad query wasm contract-store terra15nr8gcygpn9pq8urkzcf6hvzzvf0s2qt95hmjw '{"nft_info":{"token_id":"becca_nakamoto"}}'


# testnet setup script
./terrad tx wasm execute terra1zzf3207sepmhs2t8f2j0zwsklgahrtchn5hxth \
'{"mint":{"token_id":"vitalik_nakamoto", "owner":"terra1757tkx08n0cqrw7p86ny9lnxsqeth0wgp0em95", "extension": {"external_url": "https://ipfs.infura.io/ipfs/Qmf1FKrkPeipuhMdw8LUCXcwgd2QibB9vUmyJsaZXPkBeD" } }}' \
\--from test2 --chain-id=bombay-12 --fees=1000000uluna --gas=auto --broadcast-mode=block


bombay-12


#
#./terrad query wasm contract terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v
#./terrad query wasm contract-store terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v '{"contract_info":{}}'
#./terrad query wasm contract-store terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v '{"tokens":{"owner":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"}}'
#./terrad tx wasm execute terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v '{"mint":{"token_id":"1", "owner":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"}}' --from test1 --chain-id=localterra --fees=1000000uluna --gas=auto --broadcast-mode=block


# lexx@lexx-ubuntu:~/code/terra/cw721terra$ ./terrad tx wasm execute terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v '{"mint":{"token_id":"1", "owner":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"}}' --from test1 --chain-id=localterra --fees=1000000uluna --gas=auto --broadcast-mode=block
# gas estimate: 111152
# {"body":{"messages":[{"@type":"/terra.wasm.v1beta1.MsgExecuteContract","sender":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8","contract":"terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v","execute_msg":{"mint":{"token_id":"1","owner":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"}},"coins":[]}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uluna","amount":"1000000"}],"gas_limit":"111152","payer":"","granter":""}},"signatures":[]}

# confirm transaction before signing and broadcasting [y/N]: y
# code: 0
# codespace: ""
# data: 0A280A262F74657272612E7761736D2E763162657461312E4D736745786563757465436F6E7472616374
# gas_used: "110685"
# gas_wanted: "111152"
# height: "7023"
# info: ""
# logs:
# - events:
#   - attributes:
#     - key: sender
#       value: terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8
#     - key: contract_address
#       value: terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v
#     type: execute_contract
#   - attributes:
#     - key: contract_address
#       value: terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v
#     - key: action
#       value: mint
#     - key: minter
#       value: terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8
#     - key: token_id
#       value: "1"
#     type: from_contract
#   - attributes:
#     - key: action
#       value: /terra.wasm.v1beta1.MsgExecuteContract
#     - key: module
#       value: wasm
#     - key: sender
#       value: terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8
#     type: message
#   - attributes:
#     - key: contract_address
#       value: terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v
#     - key: action
#       value: mint
#     - key: minter
#       value: terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8
#     - key: token_id
#       value: "1"
#     type: wasm
#   log: ""
#   msg_index: 0
# raw_log: '[{"events":[{"type":"execute_contract","attributes":[{"key":"sender","value":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"},{"key":"contract_address","value":"terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v"}]},{"type":"from_contract","attributes":[{"key":"contract_address","value":"terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v"},{"key":"action","value":"mint"},{"key":"minter","value":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"},{"key":"token_id","value":"1"}]},{"type":"message","attributes":[{"key":"action","value":"/terra.wasm.v1beta1.MsgExecuteContract"},{"key":"module","value":"wasm"},{"key":"sender","value":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"}]},{"type":"wasm","attributes":[{"key":"contract_address","value":"terra1vc5zfwt08hu9cctdgkqk6j9y05w6ty0xexxr9v"},{"key":"action","value":"mint"},{"key":"minter","value":"terra1dcegyrekltswvyy0xy69ydgxn9x8x32zdtapd8"},{"key":"token_id","value":"1"}]}]}]'
# timestamp: ""
# tx: null
# txhash: AF046365D721AF50AE6B8E77196F149879C7834FEB4E7BADC7C59F113C03412F




{"mint":{"token_id":"towers", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmYgfE5seqrh2khVH8WTdLTLMySA4Wzse18ghQ5i5Kdh5C"}}}

{"mint":{"token_id":"trees", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmeXTrnoVsPdqiUpzkcrmZRWC8jC6e4FK23HYFhc1sDDGw"}}}

{"mint":{"token_id":"lizard", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmQP321saFCEJPMA86sY2pCkUNFn1NQ9woLuLtYHmn5nz5"}}}


{"mint":{"token_id":"tyler", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmQVDGwSvigtCZwG8N3j7a1b6LWsgudwgcsTjakncmrXte"}}}

{"mint":{"token_id":"f1", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmerJuL4RPs9s6huJyGQT3sPp32RonHg6vnRgxVe5YpNGZ"}}}

{"mint":{"token_id":"78022", "owner":"terra17lmam6zguazs5q5u6z5mmx76uj63gldnse2pdp", "extension": {"external_url": "https://ipfs.infura.io/ipfs/QmeeeLBTgMKSGybSMj44SoWR5XseiJHB8ratq25qggUaGs"}}}


