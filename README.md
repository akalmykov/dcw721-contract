# dNFT: a smart contract for derivative NFTS


This contract is a part of [DeFi & Cross-chain Interoperability Hackathon](https://gitcoin.co/issue/terra-money/bounties/2/100026890) submission that consists of two parts:

- [a cw721 contract with metadata extension](https://github.com/akalmykov/dcw721-contract/), this repository
- [front-end dApp](https://github.com/akalmykov/dcw721-dapp/)

This cw721-compatible contract that allows minting, storing and acessing derivative NFTs.


# Build

Install cargo-generate and cargo-run-script. Unless you did that before, run this line now:

`cargo install cargo-generate cargo-run-script --features vendored-openssl `

To build a wasm and optimize it for deployment run:

```
cargo wasm
cargo run-script optimize
```
# Deploy

For step-by-step deployment instructions see [the dApp repository](https://github.com/akalmykov/dcw721-dapp/).

# Implementation details
## On-chain storage of derivative NFTs

This contract introduces a new `DerivativeNft` struct field in the Metadata extension. It stores the method used to derive a new NFT, parameters and an ordered list input NFTs used to generate a derivative NFT.

```rust
#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug, Default)]
pub struct DerivativeNft {
    // The name of the algorithm used to generate a derivative NFT. Currently it can only be 'styletransfer'
    pub method: String, 
    // Parameters of the generation (e.g. stylization intensity, neural network model used, etc. )
    pub params: Option<String>, 
    // A list of tokein_id of input NFTs fed into the algorithm
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
```rust
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

To access extension data a `MetaAccess` trait was added introduced:

```rust
pub trait MetaAccess {
    fn is_derivative(&self) -> bool;
    fn get_metadata(&self) -> &Metadata;
}

impl MetaAccess for Extension {
    fn is_derivative(&self) -> bool {
        if self.is_some() {
            self.as_ref().unwrap().derivative.is_some()
        } else {
            false
        }
    }
    fn get_metadata(&self) -> &Metadata {
        self.as_ref().unwrap()
    }
}

```
## Minting NFTs

There are two kinds of NFTs that can be minted by this contract:

- "original" NFTs
- derivative NFTs

"Original" NFTs can be minted only by `minter` specified during contract's initizalization in `InstantiateMsg`.
Derivative NFTs can be minted by any NFT owner if they own all NFTs listed in `DerivativeNft.source_ids`. Upon receiving `mint` message the contract checks this that this condition is fulfilled. 


