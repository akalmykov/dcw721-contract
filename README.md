# dNFT: a smart contract for derivative NFTS


This contract is a part of [DeFi & Cross-chain Interoperability Hackathon](https://gitcoin.co/issue/terra-money/bounties/2/100026890) submission that consists of two parts:

- [a cw721 contract with metadata extension](https://github.com/akalmykov/dcw721-contract/), this repository
- [front-end dApp](https://github.com/akalmykov/dcw721-dapp/)

This is modified cw721 template that allows minting, storing and acessing derivative NFTS.


# Build

Install cargo-generate and cargo-run-script. Unless you did that before, run this line now:

`cargo install cargo-generate cargo-run-script --features vendored-openssl `

To build a wasm and optimize it for deployment run:

```
cargo wasm
cargo run-script optimize
```
# Build

For step-by-step deployment instructions see [the dApp repository](https://github.com/akalmykov/dcw721-dapp/).

# Implementation details
## Storage

This contract introduces 

```
#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug, Default)]
pub struct DerivativeNft {
    pub method: String,
    pub params: Option<String>,
    pub source_ids: Vec<String>,
}

// see: https://docs.opensea.io/docs/metadata-standards
#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug, Default)]
pub struct Metadata {
    pub image: Option<String>,
    pub image_data: Option<String>,
    pub external_url: Option<String>,
    pub description: Option<String>,
    pub name: Option<String>,
    pub attributes: Option<Vec<Trait>>,
    pub background_color: Option<String>,
    pub animation_url: Option<String>,
    pub youtube_url: Option<String>,
    pub derivative: Option<DerivativeNft>,
}

```

Sample metadata:
```
{
    "token_uri": null,
    "extension": {
        "image": null,
        "image_data": null,
        "external_url": "https://infura-ipfs.io/ipfs/QmWjPeJW8oXo6vF7Ry4zcyoaYa2q5qp6cEnGHEmqZRytkw",
        "description": null,
        "name": null,
        "attributes": null,
        "background_color": null,
        "animation_url": null,
        "youtube_url": null,
        "derivative": {
            "method": "styletransfer",
            "params": "inception:original:96:256:284",
            "source_ids": [
                "f1_f9",
                "78022_f9"
            ]
        }
    }
}
```

