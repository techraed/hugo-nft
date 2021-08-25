pragma solidity 0.8.7;

import "./HugoNFTTypes.sol";

/**
 * 1. Storage for attributes (struct) and for getting ids of attributes
 * 2. Getting name, description (and info) from storage
 * 3. Script should be changed in attribute manager
 */
contract HugoNFTStorage is HugoNFTTypes {
    bytes32 public constant SHOP_ROLE = keccak256("SHOP_ROLE");
    bytes32 public constant NFT_ADMIN_ROLE = keccak256("NFT_ADMIN_ROLE");

    string internal constant EMPTY_IPFS_CID_STRING = "";
    // Length of the CID in base58 representation
    uint256 internal constant IPFS_CID_BYTES_LENGTH = 46;

    // Script that is used to generate NFTs from traits
    Script[] nftGenerationScripts;

    // amount of attributes used to generate NFT
    uint256 internal _attributesAmount;

    // token id => generated hugo.
    mapping(uint256 => GeneratedNFT) internal _generatedNFTs;

    // token id => exclusive hugo.
    mapping(uint256 => ExclusiveNFT) internal _exclusiveNFTs;

    // keccak256 of seed => boolean. Shows whether seed was used or not.
    mapping(bytes32 => bool) internal _isUsedSeed;

    // attribute id => traits of the attribute
    mapping(uint256 => Trait[]) internal _traitsOfAttribute;

    // attribute id => ipfs cid of the folder, where traits are stored
    mapping(uint256 => AttributeIpfsCID[]) internal _attributeCIDs;
}

// There is a contract in order of values in seeds, cids, and such - the layout is
// in accordance to the following order of attributes [HEAD_ID, GLASSES_ID, BODY_ID, SHIRT_ID, SCARF_ID]